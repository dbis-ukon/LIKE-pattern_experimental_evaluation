
import os
import re
import csv
import time
import subprocess
import statistics

# -----------------------
# CONFIG
# -----------------------

DUCKDB_BINARY = "./build/release/duckdb"
DATABASE = "imdb.db"

INPUT_SQL_FILE = "path_to_method_sql_queries"

BASELINE_OUTPUT_CSV = "duckdb_runtimes.csv"
INJECTED_OUTPUT_CSV = "duck_db_injected_runtimes.csv"

LIKE_SELECTIVITY_FILE = os.path.abspath("like_selectivity.txt")
INJECTION_LOG_FILE = "injected_selectivities_log.txt"
PLAN_CHANGE_LOG_FILE = "plan_changes_log.txt"

# Drop the OS page cache before every EXPLAIN / timed run, on both the
# baseline and injected phases, so neither phase benefits from residual
# filesystem caching left over from the other phase or from a prior run.
DROP_OS_CACHE = True

# file_key -> path to injection file (format: "pattern&value" per line)
# NOTE: this dict was missing from the pasted file - restored using the
# paths from earlier versions of this script. Update if they've changed.
INJECTION_FILES = {
    "actor":   "actor_inject_estimates.csv",
    "akatitle":"akatitle_inject_estimates.csv",
    "charname":charname_inject_estimates.csv",
    "company": "company_inject_estimates.csv",
    "title":   "title_inject_estimates.csv",
    "keyword": "keyword_inject_estimates.csv",
}


# file_key -> (table, column) that file's patterns apply to

INJECTION_FILE_TABLE_MAP = {
    "actor": ("name", "name"),
    "akatitle": ("aka_title", "title"),
    "charname": ("char_name", "name"),
    "company": ("company_name", "name"),
    "title": ("title", "title"),
    "keyword": ("keyword", "keyword"),
}

ALLOWED_COLUMNS = set(INJECTION_FILE_TABLE_MAP.values())

TIMEOUT_SECONDS = 3 * 60  # 3 minutes, matches original TIMEOUT_MS
RUNS_PER_QUERY = 3


# -----------------------
# OS PAGE CACHE CONTROL (for true cold-cache runs)
# -----------------------

_cache_drop_warned = False


def drop_os_cache():
    """
    Flush dirty pages and drop the OS page cache (dentries + inodes +
    pagecache) so the next subprocess call reads imdb.db cold from disk,
    not from filesystem cache left over from a previous run/phase.

    Requires root. Uses passwordless sudo for the specific `tee` command
    so the rest of the script does not need to run as root. If this
    fails (e.g. no sudo rule configured), we warn once and continue -
    runs will still be cold at the DuckDB-process level (fresh process
    per call) but not guaranteed cold at the filesystem level.
    """
    global _cache_drop_warned

    if not DROP_OS_CACHE:
        return

    try:
        subprocess.run(["sync"], check=False, timeout=30)
        result = subprocess.run(
            ["sudo", "-n", "sh", "-c", "echo 3 > /proc/sys/vm/drop_caches"],
            capture_output=True,
            text=True,
            timeout=30,
        )
        if result.returncode != 0 and not _cache_drop_warned:
            print(f"  [WARN] could not drop OS page cache (sudo failed): "
                  f"{result.stderr.strip()[:200]}")
            print("  [WARN] runs will be cold at the DuckDB-process level only, "
                  "not the filesystem level. See module docstring for the sudoers fix.")
            _cache_drop_warned = True
    except Exception as e:
        if not _cache_drop_warned:
            print(f"  [WARN] could not drop OS page cache: {e}")
            print("  [WARN] runs will be cold at the DuckDB-process level only, "
                  "not the filesystem level. See module docstring for the sudoers fix.")
            _cache_drop_warned = True


def check_cache_drop_capability():
    """Verify at startup whether cache-dropping actually works, so the
    user knows up front whether their runs will be filesystem-cold."""
    if not DROP_OS_CACHE:
        print("DROP_OS_CACHE is disabled - runs will only be cold at the "
              "DuckDB-process level.\n")
        return

    try:
        result = subprocess.run(
            ["sudo", "-n", "sh", "-c", "echo 3 > /proc/sys/vm/drop_caches"],
            capture_output=True,
            text=True,
            timeout=30,
        )
        if result.returncode == 0:
            print("OS page cache drop is working - baseline and injected runs "
                  "will both be filesystem-cold.\n")
        else:
            print("[WARN] OS page cache drop is NOT working (sudo check failed). "
                  "Runs will only be cold at the DuckDB-process level.\n")
    except Exception as e:
        print(f"[WARN] OS page cache drop is NOT working ({e}). "
              "Runs will only be cold at the DuckDB-process level.\n")


# -----------------------
# SQL SPLITTING (quote-aware, unchanged logic from original)
# -----------------------

def is_real_query(s):
    s = s.strip()
    if not s:
        return False
    lines = [l for l in s.splitlines() if l.strip() and not l.strip().startswith("--")]
    return bool(lines)


def split_statements(content: str) -> list:
    statements = []
    buf = []
    in_string = False
    i = 0
    n = len(content)

    while i < n:
        ch = content[i]
        if in_string:
            buf.append(ch)
            if ch == "'":
                if i + 1 < n and content[i + 1] == "'":
                    buf.append(content[i + 1]);
                    i += 2;
                    continue
                in_string = False
            i += 1;
            continue
        if ch == "'":
            in_string = True;
            buf.append(ch);
            i += 1;
            continue
        if ch == ";":
            stmt = "".join(buf).strip()
            if is_real_query(stmt):
                statements.append(stmt)
            buf = [];
            i += 1;
            continue
        buf.append(ch);
        i += 1

    tail = "".join(buf).strip()
    if is_real_query(tail):
        statements.append(tail)
    return statements


# -----------------------
# WITH-CLAUSE SKIPPING (find where the outer/final query actually begins)
# -----------------------

def skip_with_clause(stmt: str) -> int:
    """
    If stmt starts with 'WITH cte1 AS (...), cte2 AS (...), ... SELECT ...',
    returns the index where the OUTER/final query's SELECT begins (skipping
    past the entire CTE list, paren-depth-aware). Returns 0 if stmt doesn't
    start with WITH.

    This matters because relax_group_by/relax_order_by/extract_select_aliases
    need to know whether the OUTER query itself has a GROUP BY and what its
    OWN select-list aliases are - not whether some CTE nested inside the WITH
    clause happens to have a GROUP BY. Without this, a naive whole-statement
    regex search for "GROUP BY" would find the CTE's GROUP BY and wrongly
    conclude the outer query needs the same relaxation treatment, even when
    the outer query has no GROUP BY of its own at all.
    """
    m = re.match(r'^\s*WITH\b', stmt, re.IGNORECASE)
    if not m:
        return 0
    i = m.end()
    n = len(stmt)
    depth = 0
    in_string = False
    while i < n:
        ch = stmt[i]
        if in_string:
            if ch == "'":
                if i + 1 < n and stmt[i + 1] == "'":
                    i += 2;
                    continue
                in_string = False
            i += 1;
            continue
        if ch == "'":
            in_string = True;
            i += 1;
            continue
        if ch == '(':
            depth += 1;
            i += 1;
            continue
        if ch == ')':
            depth -= 1;
            i += 1;
            continue
        if depth == 0 and stmt[i:i + 6].upper() == "SELECT":
            before_ok = (not stmt[i - 1].isalnum() and stmt[i - 1] != '_')
            after_ok = (i + 6 >= n) or (not stmt[i + 6].isalnum() and stmt[i + 6] != '_')
            if before_ok and after_ok:
                return i
        i += 1
    return 0


# -----------------------
# GROUP BY / ORDER BY RELAXATION (DuckDB strict-SQL compatibility)
# -----------------------

def extract_select_aliases(stmt: str) -> set:
    offset = skip_with_clause(stmt)
    stmt = stmt[offset:]

    m = re.match(r'^\s*SELECT\b', stmt, re.IGNORECASE)
    if not m:
        return set()
    select_start = m.end()
    m2 = re.match(r'\s*DISTINCT\b', stmt[select_start:], re.IGNORECASE)
    if m2:
        select_start += m2.end()

    depth = 0
    in_string = False
    i = select_start
    n = len(stmt)
    from_pos = None
    while i < n:
        ch = stmt[i]
        if in_string:
            if ch == "'":
                if i + 1 < n and stmt[i + 1] == "'":
                    i += 2
                    continue
                in_string = False
            i += 1
            continue
        if ch == "'":
            in_string = True
            i += 1
            continue
        if ch == '(':
            depth += 1
            i += 1
            continue
        if ch == ')':
            depth -= 1
            i += 1
            continue
        if depth == 0 and stmt[i:i + 4].upper() == "FROM":
            before_ok = (i == 0) or (not stmt[i - 1].isalnum() and stmt[i - 1] != '_')
            after_ok = (i + 4 >= n) or (not stmt[i + 4].isalnum() and stmt[i + 4] != '_')
            if before_ok and after_ok:
                from_pos = i
                break
        i += 1
    if from_pos is None:
        return set()

    select_list = stmt[select_start:from_pos]

    parts = []
    depth = 0
    in_string = False
    buf = []
    j = 0
    m3 = len(select_list)
    while j < m3:
        ch = select_list[j]
        if in_string:
            buf.append(ch)
            if ch == "'":
                if j + 1 < m3 and select_list[j + 1] == "'":
                    buf.append(select_list[j + 1])
                    j += 2
                    continue
                in_string = False
            j += 1
            continue
        if ch == "'":
            in_string = True
            buf.append(ch)
            j += 1
            continue
        if ch == '(':
            depth += 1
            buf.append(ch)
            j += 1
            continue
        if ch == ')':
            depth -= 1
            buf.append(ch)
            j += 1
            continue
        if ch == ',' and depth == 0:
            parts.append(''.join(buf))
            buf = []
            j += 1
            continue
        buf.append(ch)
        j += 1
    if buf:
        parts.append(''.join(buf))

    aliases = set()
    for part in parts:
        m4 = re.search(r'\bAS\s+([a-zA-Z_][a-zA-Z0-9_]*)\s*$', part.strip(), re.IGNORECASE)
        if m4:
            aliases.add(m4.group(1).lower())
    return aliases


def relax_group_by(stmt: str) -> str:
    offset = skip_with_clause(stmt)
    prefix = stmt[:offset]
    sub = stmt[offset:]

    if not re.search(r'\bGROUP\s+BY\b', sub, re.IGNORECASE):
        return stmt

    m = re.match(r'^\s*SELECT\b', sub, re.IGNORECASE)
    if not m:
        return stmt
    select_start = m.end()

    m2 = re.match(r'\s*DISTINCT\b', sub[select_start:], re.IGNORECASE)
    if m2:
        select_start += m2.end()

    depth = 0
    in_string = False
    i = select_start
    n = len(sub)
    from_pos = None
    while i < n:
        ch = sub[i]
        if in_string:
            if ch == "'":
                if i + 1 < n and sub[i + 1] == "'":
                    i += 2
                    continue
                in_string = False
            i += 1
            continue
        if ch == "'":
            in_string = True
            i += 1
            continue
        if ch == '(':
            depth += 1
            i += 1
            continue
        if ch == ')':
            depth -= 1
            i += 1
            continue
        if depth == 0 and sub[i:i + 4].upper() == "FROM":
            before_ok = (i == 0) or (not sub[i - 1].isalnum() and sub[i - 1] != '_')
            after_ok = (i + 4 >= n) or (not sub[i + 4].isalnum() and sub[i + 4] != '_')
            if before_ok and after_ok:
                from_pos = i
                break
        i += 1
    if from_pos is None:
        return stmt

    select_list = sub[select_start:from_pos]
    rest = sub[from_pos:]

    parts = []
    depth = 0
    in_string = False
    buf = []
    j = 0
    m3 = len(select_list)
    while j < m3:
        ch = select_list[j]
        if in_string:
            buf.append(ch)
            if ch == "'":
                if j + 1 < m3 and select_list[j + 1] == "'":
                    buf.append(select_list[j + 1])
                    j += 2
                    continue
                in_string = False
            j += 1
            continue
        if ch == "'":
            in_string = True
            buf.append(ch)
            j += 1
            continue
        if ch == '(':
            depth += 1
            buf.append(ch)
            j += 1
            continue
        if ch == ')':
            depth -= 1
            buf.append(ch)
            j += 1
            continue
        if ch == ',' and depth == 0:
            parts.append(''.join(buf))
            buf = []
            j += 1
            continue
        buf.append(ch)
        j += 1
    if buf:
        parts.append(''.join(buf))

    AGG_RE = re.compile(
        r'^\s*(COUNT|SUM|MIN|MAX|AVG|ANY_VALUE|STRING_AGG|ARRAY_AGG|LIST)\s*\(',
        re.IGNORECASE
    )
    WINDOW_RE = re.compile(r'\bOVER\s*\(', re.IGNORECASE)
    SIMPLE_COLUMN_RE = re.compile(r'^([a-zA-Z_][a-zA-Z0-9_]*)\s*\.\s*([a-zA-Z_][a-zA-Z0-9_]*)$')
    BARE_IDENTIFIER_RE = re.compile(r'^[a-zA-Z_][a-zA-Z0-9_]*$')

    new_parts = []
    for part in parts:
        stripped = part.strip()
        if stripped == '*' or AGG_RE.match(stripped) or WINDOW_RE.search(stripped):
            new_parts.append(part)
            continue
        as_match = re.search(r'\bAS\b', stripped, re.IGNORECASE)
        if as_match:
            expr_part = stripped[:as_match.start()].rstrip()
            alias_part = stripped[as_match.start():]
            wrapped = f"ANY_VALUE({expr_part}) {alias_part}"
        else:
            col_match = SIMPLE_COLUMN_RE.match(stripped)
            if col_match:
                implicit_name = col_match.group(2)
                wrapped = f"ANY_VALUE({stripped}) AS {implicit_name}"
            elif BARE_IDENTIFIER_RE.match(stripped):
                wrapped = f"ANY_VALUE({stripped}) AS {stripped}"
            else:
                wrapped = f"ANY_VALUE({stripped})"
        new_parts.append(' ' + wrapped)

    new_select_list = ','.join(new_parts)
    new_sub = sub[:select_start] + new_select_list.rstrip() + ' ' + rest
    return prefix + new_sub


def relax_order_by(stmt: str) -> str:
    offset = skip_with_clause(stmt)
    prefix = stmt[:offset]
    sub = stmt[offset:]

    if not re.search(r'\bGROUP\s+BY\b', sub, re.IGNORECASE):
        return stmt

    known_aliases = extract_select_aliases(sub)

    depth = 0
    in_string = False
    i = 0
    n = len(sub)
    order_by_start = None
    while i < n:
        ch = sub[i]
        if in_string:
            if ch == "'":
                if i + 1 < n and sub[i + 1] == "'":
                    i += 2
                    continue
                in_string = False
            i += 1
            continue
        if ch == "'":
            in_string = True
            i += 1
            continue
        if ch == '(':
            depth += 1
            i += 1
            continue
        if ch == ')':
            depth -= 1
            i += 1
            continue
        if depth == 0 and sub[i:i + 8].upper() == "ORDER BY":
            before_ok = (i == 0) or (not sub[i - 1].isalnum() and sub[i - 1] != '_')
            after_ok = (i + 8 >= n) or (not sub[i + 8].isalnum() and sub[i + 8] != '_')
            if before_ok and after_ok:
                order_by_start = i + 8
                break
        i += 1

    if order_by_start is None:
        return stmt

    before = sub[:order_by_start]

    depth = 0
    in_string = False
    i = order_by_start
    end_pos = n
    while i < n:
        ch = sub[i]
        if in_string:
            if ch == "'":
                if i + 1 < n and sub[i + 1] == "'":
                    i += 2
                    continue
                in_string = False
            i += 1
            continue
        if ch == "'":
            in_string = True
            i += 1
            continue
        if ch == '(':
            depth += 1
            i += 1
            continue
        if ch == ')':
            depth -= 1
            i += 1
            continue
        if depth == 0 and sub[i:i + 5].upper() == "LIMIT":
            before_ok = (not sub[i - 1].isalnum() and sub[i - 1] != '_')
            after_ok = (i + 5 >= n) or (not sub[i + 5].isalnum() and sub[i + 5] != '_')
            if before_ok and after_ok:
                end_pos = i
                break
        i += 1

    order_clause = sub[order_by_start:end_pos]
    after = sub[end_pos:]

    parts = []
    depth = 0
    in_string = False
    buf = []
    j = 0
    m = len(order_clause)
    while j < m:
        ch = order_clause[j]
        if in_string:
            buf.append(ch)
            if ch == "'":
                if j + 1 < m and order_clause[j + 1] == "'":
                    buf.append(order_clause[j + 1])
                    j += 2
                    continue
                in_string = False
            j += 1
            continue
        if ch == "'":
            in_string = True
            buf.append(ch)
            j += 1
            continue
        if ch == '(':
            depth += 1
            buf.append(ch)
            j += 1
            continue
        if ch == ')':
            depth -= 1
            buf.append(ch)
            j += 1
            continue
        if ch == ',' and depth == 0:
            parts.append(''.join(buf))
            buf = []
            j += 1
            continue
        buf.append(ch)
        j += 1
    if buf:
        parts.append(''.join(buf))

    AGG_RE = re.compile(
        r'^\s*(COUNT|SUM|MIN|MAX|AVG|ANY_VALUE|STRING_AGG|ARRAY_AGG|LIST)\s*\(',
        re.IGNORECASE
    )
    SUFFIX_RE = re.compile(r'\s+(ASC|DESC)?\s*(NULLS\s+(FIRST|LAST))?\s*$', re.IGNORECASE)
    ORDINAL_RE = re.compile(r'^\s*\d+\s*$')

    new_parts = []
    for part in parts:
        suffix_match = SUFFIX_RE.search(part)
        if suffix_match and suffix_match.group(0).strip():
            core = part[:suffix_match.start()]
            suffix = part[suffix_match.start():]
        else:
            core = part
            suffix = ''

        core_stripped = core.strip()
        if (ORDINAL_RE.match(core_stripped) or AGG_RE.match(core_stripped) or not core_stripped
                or core_stripped.lower() in known_aliases):
            new_parts.append(part)
            continue

        new_parts.append(f" ANY_VALUE({core_stripped}){suffix}")

    new_order_clause = ','.join(new_parts)
    new_sub = before + new_order_clause + after
    return prefix + new_sub


def relax_subqueries_recursive(stmt: str) -> str:
    result = []
    i = 0
    n = len(stmt)
    in_string = False
    while i < n:
        ch = stmt[i]
        if in_string:
            result.append(ch)
            if ch == "'":
                if i + 1 < n and stmt[i + 1] == "'":
                    result.append(stmt[i + 1]);
                    i += 2;
                    continue
                in_string = False
            i += 1;
            continue
        if ch == "'":
            in_string = True;
            result.append(ch);
            i += 1;
            continue
        if ch == '(':
            j = i + 1
            while j < n and stmt[j].isspace():
                j += 1
            if stmt[j:j + 6].upper() == "SELECT" and (j + 6 >= n or not stmt[j + 6].isalnum()):
                depth = 1
                k = j
                in_str2 = False
                while k < n and depth > 0:
                    c2 = stmt[k]
                    if in_str2:
                        if c2 == "'":
                            if k + 1 < n and stmt[k + 1] == "'":
                                k += 2;
                                continue
                            in_str2 = False
                        k += 1;
                        continue
                    if c2 == "'":
                        in_str2 = True;
                        k += 1;
                        continue
                    if c2 == '(':
                        depth += 1
                    elif c2 == ')':
                        depth -= 1
                        if depth == 0:
                            break
                    k += 1
                inner = stmt[j:k]
                inner = relax_subqueries_recursive(inner)
                inner = relax_group_by(inner)
                inner = relax_order_by(inner)
                result.append('(')
                result.append(inner)
                result.append(')')
                i = k + 1
                continue
        result.append(ch)
        i += 1
    return ''.join(result)


def relax_all(stmt: str) -> str:
    stmt = relax_subqueries_recursive(stmt)
    stmt = relax_group_by(stmt)
    stmt = relax_order_by(stmt)
    return stmt


# -----------------------
# ALIAS -> TABLE RESOLUTION
# -----------------------

_RESERVED_ALIASES = {
    "ON", "WHERE", "GROUP", "ORDER", "HAVING", "LIMIT",
    "UNION", "EXCEPT", "INTERSECT", "AS", "USING",
}


def extract_alias_map(sql):
    alias_map = {}
    regex = re.compile(
        r"""
        \b(?:FROM|JOIN)
        \s+
        ([a-zA-Z_][a-zA-Z0-9_]*)
        (?:\s+AS)?
        \s+
        ([a-zA-Z_][a-zA-Z0-9_]*)
        """,
        re.IGNORECASE | re.VERBOSE
    )
    for table, alias in regex.findall(sql):
        if alias.upper() in _RESERVED_ALIASES:
            continue
        alias_map[alias.lower()] = table.lower()
    return alias_map


_PRED_LIKE_RE = re.compile(
    r"""
    ([a-zA-Z_][a-zA-Z0-9_]*)        # alias
    \.
    ([a-zA-Z_][a-zA-Z0-9_]*)        # column
    \s+
    (NOT\s+LIKE|LIKE)                # operator
    \s+
    '((?:[^'\\]|\\.|'')*)'           # pattern (handles doubled '' escapes)
    """,
    re.IGNORECASE | re.VERBOSE
)


def sql_unescape(pattern: str) -> str:
    return pattern.replace("''", "'")


# -----------------------
# INJECTION LOOKUP (exact match by pattern, per table/column)
# -----------------------

class SelectivityLookup:
    def __init__(self, files: dict, table_map: dict):
        self.lookups = {}
        self.hits = 0
        self.misses = 0

        for file_key, file_path in files.items():
            table_column = table_map.get(file_key)
            if table_column is None:
                print(f"  [WARN] no table/column mapping for '{file_key}' - skipping {file_path}")
                continue
            if not os.path.exists(file_path):
                print(f"  [WARN] injection file not found: {file_path} - skipping")
                continue

            pattern_dict = self._load_dict(file_path)
            self.lookups[table_column] = pattern_dict
            print(f"  loaded {len(pattern_dict)} unique pattern(s) from {file_key} -> {table_column}")

    @staticmethod
    def _load_dict(file_path):
        d = {}
        dup_count = 0
        with open(file_path, encoding="utf-8") as f:
            for line in f:
                parts = line.rstrip("\n").split('&')
                if len(parts) != 2:
                    continue
                pattern, value = parts[0], parts[1]
                if pattern in d:
                    dup_count += 1
                d[pattern] = value
        if dup_count:
            print(f"    [WARN] {dup_count} duplicate pattern(s) in {file_path}, last value kept")
        return d

    def lookup(self, table, column, pattern):
        col_dict = self.lookups.get((table, column))
        if col_dict is None:
            self.misses += 1
            return None
        value = col_dict.get(pattern)
        if value is None:
            self.misses += 1
            return None
        self.hits += 1
        return value

    def summary(self):
        total = self.hits + self.misses
        pct = (self.hits / total * 100) if total else 0.0
        print(f"\n  Selectivity lookup summary: {self.hits}/{total} predicate(s) "
              f"matched an exact injected pattern ({pct:.1f}%), "
              f"{self.misses} fell back to DuckDB's own estimate.")


# -----------------------
# QUERY -> like_selectivity.txt
# -----------------------

def extract_injectable_patterns(stmt: str, lookup: SelectivityLookup) -> dict:
    alias_to_table = extract_alias_map(stmt)
    matched = {}

    for alias, column, op, raw_pattern in _PRED_LIKE_RE.findall(stmt):
        table = alias_to_table.get(alias.lower())
        if table is None:
            continue
        column = column.lower()
        if (table, column) not in ALLOWED_COLUMNS:
            continue

        pattern = sql_unescape(raw_pattern)
        value = lookup.lookup(table, column, pattern)
        if value is not None:
            matched[pattern] = value

    return matched


def write_like_selectivity_file(matched: dict):
    with open(LIKE_SELECTIVITY_FILE, "w") as f:
        for pattern, value in matched.items():
            f.write(f"{pattern}\t{float(value):.10f}\n")


def log_injected_patterns(log_path: str, query_no: int, matched: dict):
    with open(log_path, "a", encoding="utf-8") as f:
        f.write(f"Query {query_no}\n")
        f.write("-" * 40 + "\n")
        if matched:
            for pattern, value in matched.items():
                f.write(f"{pattern}\t{float(value):.10f}\n")
        else:
            f.write("(no patterns injected - no matches in injection files)\n")
        f.write("\n")


def clear_like_selectivity_file():
    open(LIKE_SELECTIVITY_FILE, "w").close()


# -----------------------
# PLAN COMPARISON (did the join order / plan structure actually change?)
# -----------------------

def get_explain_plan(stmt: str) -> str:
    drop_os_cache()
    explain_sql = "EXPLAIN " + stmt.rstrip().rstrip(";") + ";"
    result = subprocess.run(
        [DUCKDB_BINARY, DATABASE, "-c", explain_sql],
        capture_output=True,
        text=True,
        timeout=TIMEOUT_SECONDS,
    )
    if result.returncode != 0:
        return ""
    return result.stdout


_TABLE_RE = re.compile(r'Table:\s*(\S+)')
_JOIN_COND_RE = re.compile(r'Conditions:\s*\n?\s*([^\n╭╰│]+)')


def plan_signature(explain_text: str):
    tables = tuple(_TABLE_RE.findall(explain_text))
    joins = tuple(m.strip() for m in _JOIN_COND_RE.findall(explain_text))
    return (tables, joins)


def log_plan_change(log_path: str, query_no: int, changed: bool, estimate_changed: bool,
                    baseline_explain: str, injected_explain: str):
    with open(log_path, "a", encoding="utf-8") as f:
        f.write(f"Query {query_no}\n")
        f.write("-" * 40 + "\n")
        f.write(f"Join order / plan structure changed: {changed}\n")
        f.write(f"Row estimates changed (raw text differs): {estimate_changed}\n")
        if changed:
            f.write("\n--- BASELINE PLAN ---\n")
            f.write(baseline_explain)
            f.write("\n--- INJECTED PLAN ---\n")
            f.write(injected_explain)
        f.write("\n")


# -----------------------
# QUERY EXECUTION
# -----------------------

def run_query(stmt: str):
    drop_os_cache()
    start = time.perf_counter()
    try:
        result = subprocess.run(
            [DUCKDB_BINARY, DATABASE, "-c", stmt],
            capture_output=True,
            text=True,
            timeout=TIMEOUT_SECONDS,
        )
        elapsed = time.perf_counter() - start
        if result.returncode != 0:
            print(f"      FAILED - {result.stderr.strip()[:200]}")
            return elapsed, "failed"
        return elapsed, "ok"
    except subprocess.TimeoutExpired:
        elapsed = time.perf_counter() - start
        return elapsed, "timeout"


# -----------------------
# STATS / ROW BUILDING
# -----------------------

def build_row(query_no, times_list, timed_out, failed, plan_changed):
    valid = [t for t in times_list if isinstance(t, (int, float))]
    avg_t = sum(valid) / len(valid) if valid else None
    median_t = statistics.median(valid) if valid else None
    min_t = min(valid) if valid else None
    max_t = max(valid) if valid else None
    stdev_t = statistics.stdev(valid) if len(valid) >= 2 else None

    return (
            [query_no] + times_list
            + [avg_t, median_t, min_t, max_t, stdev_t, len(valid), timed_out, failed, plan_changed]
    )


HEADER_SUFFIX = ["avg(s)", "median(s)", "min(s)", "max(s)", "stdev(s)", "n_valid_runs",
                 "timed_out", "failed", "plan_changed"]


def run_phase(stmt: str):
    times_list = []
    timed_out = False
    failed = False

    for run in range(RUNS_PER_QUERY):
        elapsed, status = run_query(stmt)
        if status == "ok":
            times_list.append(elapsed)
            print(f"    run {run + 1}: ok ({elapsed:.4f}s)")
        else:
            times_list.append(status)
            print(f"    run {run + 1}: {status}")
            if status == "timeout":
                timed_out = True
            else:
                failed = True
            remaining = RUNS_PER_QUERY - run - 1
            times_list.extend([status] * remaining)
            break

    return times_list, timed_out, failed


# -----------------------
# MAIN
# -----------------------

def main():
    for path in (BASELINE_OUTPUT_CSV, INJECTED_OUTPUT_CSV):
        out_dir = os.path.dirname(path)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)

    check_cache_drop_capability()

    with open(INPUT_SQL_FILE, "r", encoding="utf-8") as f:
        content = f.read()
    statements = split_statements(content)
    statements = [relax_all(s) for s in statements]
    num_queries = len(statements)
    print(f"\nTOTAL QUERIES FOUND: {num_queries}\n")

    print("Loading selectivity lookup tables...")
    lookup = SelectivityLookup(INJECTION_FILES, INJECTION_FILE_TABLE_MAP)
    print()

    open(INJECTION_LOG_FILE, "w").close()
    open(PLAN_CHANGE_LOG_FILE, "w").close()
    print(f"Injected selectivities will be logged to: {INJECTION_LOG_FILE}")
    print(f"Plan change details will be logged to: {PLAN_CHANGE_LOG_FILE}\n")

    time_cols = [f"t{r + 1}(s)" for r in range(RUNS_PER_QUERY)]
    header = ["Query No"] + time_cols + HEADER_SUFFIX

    baseline_rows = []
    injected_rows = []

    total_timeouts = 0
    total_failures = 0
    plan_changed_count = 0
    estimate_changed_count = 0
    both_explains_ok_count = 0
    run_start_all = time.time()

    for i, stmt in enumerate(statements):
        print(f"[Query {i + 1}/{num_queries}]")

        if not stmt.strip():
            continue

        clear_like_selectivity_file()
        baseline_explain = get_explain_plan(stmt)
        b_times, b_timed_out, b_failed = run_phase(stmt)
        if b_timed_out:
            total_timeouts += 1
        if b_failed:
            total_failures += 1

        matched = extract_injectable_patterns(stmt, lookup)
        write_like_selectivity_file(matched)
        log_injected_patterns(INJECTION_LOG_FILE, i + 1, matched)
        if matched:
            print(f"    injecting {len(matched)} pattern(s) for this query")

        injected_explain = get_explain_plan(stmt)
        j_times, j_timed_out, j_failed = run_phase(stmt)
        if j_timed_out:
            total_timeouts += 1
        if j_failed:
            total_failures += 1

        plan_changed = False
        estimate_changed = False
        if baseline_explain and injected_explain:
            both_explains_ok_count += 1
            estimate_changed = (baseline_explain.strip() != injected_explain.strip())
            plan_changed = (plan_signature(baseline_explain) != plan_signature(injected_explain))
            if plan_changed:
                plan_changed_count += 1
                print(f"    [PLAN CHANGED] join order/structure differs from baseline")
            if estimate_changed:
                estimate_changed_count += 1
        log_plan_change(PLAN_CHANGE_LOG_FILE, i + 1, plan_changed, estimate_changed,
                        baseline_explain, injected_explain)

        clear_like_selectivity_file()

        baseline_rows.append(build_row(i + 1, b_times, b_timed_out, b_failed, plan_changed))
        injected_rows.append(build_row(i + 1, j_times, j_timed_out, j_failed, plan_changed))

    lookup.summary()

    total_wall_all = time.time() - run_start_all
    print(f"\nTotal benchmark wall time: {total_wall_all / 60:.1f} min")
    print(f"Timeouts: {total_timeouts}   Failures: {total_failures}")
    print(f"\nPlan comparison (of {both_explains_ok_count}/{num_queries} queries where both "
          f"EXPLAIN calls succeeded):")
    print(f"  Join order / plan structure changed: {plan_changed_count}/{both_explains_ok_count}")
    print(f"  Row estimates changed (any difference in plan text): {estimate_changed_count}/{both_explains_ok_count}")
    print(f"  Full details in: {PLAN_CHANGE_LOG_FILE}")

    with open(BASELINE_OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(baseline_rows)

    with open(INJECTED_OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(injected_rows)

    print("\nDone.")
    print(f"   Total queries: {num_queries}")
    print(f"   Baseline CSV:  {BASELINE_OUTPUT_CSV}")
    print(f"   Injected CSV:  {INJECTED_OUTPUT_CSV}")
    print(f"   Injection log: {INJECTION_LOG_FILE}")
    print(f"   Plan change log: {PLAN_CHANGE_LOG_FILE}")


if __name__ == "__main__":
    main()
