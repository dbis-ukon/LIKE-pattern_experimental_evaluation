import os
import csv
import time
import statistics
import psycopg2
from psycopg2 import errors
import re

INPUT_SQL_FILE = "path_to_method_sql_quries"

BASELINE_OUTPUT_CSV = "postgresql_runtimes.csv"
INJECTED_OUTPUT_CSV = "postgresql_injected_runtimes.csv"
PREDICATES_PATH = os.path.abspath("predicates.txt")
SELECTIVITIES_PATH = os.path.abspath("selectivities.txt")

INJECTION_FILES = {
    "actor": "actor_injection_estimates",
    "akatitle": "akatitle_injection_estimates",
    "charname": "charname_injection_estimates",
    "company": "companyname_injection_estimates",
    "title": "title_injection_estimates",
    "keyword": "keywords_injection_estimates.txt",
}

INJECTION_FILE_TABLE_MAP = {
    "actor":    ("name", "name"),
    "akatitle": ("aka_title", "title"),
    "charname": ("char_name", "name"),
    "company":  ("company_name", "name"),
    "title":    ("title", "title"),
    "keyword":  ("keyword", "keyword"),
}

ALLOWED_COLUMNS = set(INJECTION_FILE_TABLE_MAP.values())

TIMEOUT_MS = 3 * 60_000
RUNS_PER_QUERY = 3

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "dbname": "inject_db",
    "user": "mehmet",
    "password": "postgres",
}

# -----------------------
# SQL SPLITTING
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
                    buf.append(content[i + 1]); i += 2; continue
                in_string = False
            i += 1; continue
        if ch == "'":
            in_string = True; buf.append(ch); i += 1; continue
        if ch == ";":
            stmt = "".join(buf).strip()
            if is_real_query(stmt):
                statements.append(stmt)
            buf = []; i += 1; continue
        buf.append(ch); i += 1

    tail = "".join(buf).strip()
    if is_real_query(tail):
        statements.append(tail)
    return statements


# -----------------------
# ALIAS -> TABLE RESOLUTION
# -----------------------

_RESERVED_ALIASES = {
    "ON", "WHERE", "GROUP", "ORDER", "HAVING", "LIMIT",
    "UNION", "EXCEPT", "INTERSECT", "AS", "USING",
}


def extract_alias_map(sql):
    """
    FROM title t
    JOIN keyword k
    ->
    {"t": "title", "k": "keyword"}
    """
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
        alias_map[alias] = table
    return alias_map


# Matches predicates.txt LHS entries like:
#   k.keyword ~~ '-c_ty%'
#   c.name !~~ '%foo%'
_PRED_LIKE_RE = re.compile(
    r"""
    ^\s*
    ([a-zA-Z_][a-zA-Z0-9_]*)     # alias
    \.
    ([a-zA-Z_][a-zA-Z0-9_]*)     # column
    \s*
    (!?~~)                       # ~~ (LIKE) or !~~ (NOT LIKE)
    \s*
    '(.*)'                       # pattern
    \s*$
    """,
    re.VERBOSE
)


# -----------------------
# INJECTION LOOKUP (exact match by pattern, per column)
# -----------------------

class SelectivityLookup:

    def __init__(self, files: dict, table_map: dict):
        self.lookups = {}   # (table, column) -> {pattern: value}
        self.hits = 0
        self.misses = 0

        for file_key, file_path in files.items():
            table_column = table_map.get(file_key)
            if table_column is None:
                print(f"  [WARN] no table/column mapping for '{file_key}' — skipping {file_path}")
                continue

            pattern_dict = self._load_dict(file_path)
            self.lookups[table_column] = pattern_dict
            print(f"  loaded {len(pattern_dict)} unique pattern(s) from {file_key} -> {table_column}")

    @staticmethod
    def _load_dict(file_path):
        """
        Reads 'pattern&value' lines into a dict. If the same pattern
        appears more than once in the file, the LAST occurrence wins
        (flagged via a warning so duplicates aren't silently hidden).
        """
        d = {}
        dup_count = 0
        with open(file_path, encoding="utf-8") as f:
            for line in f:
                parts = line.rstrip("\n").split('    ')
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
              f"{self.misses} fell back to Postgres's own estimate.")


# -----------------------
# CORE: predicates.txt -> selectivities.txt
# -----------------------

def compute_selectivities(predicates_path: str, selectivities_path: str,
                           lookup: SelectivityLookup, stmt: str = None):
    stmt_lower = stmt.lower() if stmt else None
    alias_to_table = extract_alias_map(stmt) if stmt else {}

    hit_count = 0
    fallback_count = 0
    total_lines = 0

    with open(selectivities_path, "w") as newfile:
        if os.path.exists(predicates_path):
            with open(predicates_path) as f:
                for raw_line in f:
                    line = raw_line.strip()
                    if not line or ',' not in line:
                        continue
                    total_lines += 1

                    # split off trailing pg selectivity on the LAST comma,
                    # so commas inside the pattern don't break the split
                    lhs, _, pg_selectivity = line.rpartition(',')
                    lhs = lhs.strip()
                    pg_selectivity = pg_selectivity.strip()

                    # drop predicates not belonging to this query
                    # (internal catalog noise)
                    if stmt_lower and '.' in lhs:
                        alias = lhs.split('.', 1)[0].strip().lower()
                        if f"{alias}." not in stmt_lower:
                            continue

                    k = pg_selectivity  # default: keep Postgres's own value

                    m = _PRED_LIKE_RE.match(lhs)
                    if m:
                        p_alias, column, op, pattern = m.groups()
                        table = alias_to_table.get(p_alias)

                        if table is not None and (table, column) in ALLOWED_COLUMNS:
                            value = lookup.lookup(table, column, pattern)
                            if value is not None:
                                val = float(value)
                                if op == '!~~':
                                    val = 1.0 - val
                                k = f"{val:.10f}"
                                hit_count += 1
                            else:
                                fallback_count += 1
                        else:
                            fallback_count += 1

                    newfile.write(str(k) + '\n')

    if fallback_count:
        print(f"    [compute_selectivities] {hit_count} injected, "
              f"{fallback_count}/{total_lines} fell back to Postgres estimate.")

    os.chmod(selectivities_path, 0o777)


def clear_predicates_file(path: str):
    if os.path.exists(path):
        os.remove(path)
    open(path, "w").close()
    os.chmod(path, 0o777)


def remove_file_if_exists(path: str):
    if os.path.exists(path):
        os.remove(path)


# -----------------------
# EXPLAIN RUN HELPER
# -----------------------

def run_explain(cursor, conn, stmt):
    t0 = time.time()
    try:
        cursor.execute(f"EXPLAIN (ANALYZE, BUFFERS) {stmt}")
        plan_results = cursor.fetchall()
        plan_text = "\n".join(row[0] for row in plan_results)

        plan_time_ms = None
        execution_time_ms = None
        for line in plan_text.splitlines():
            line_lower = line.lower()
            if "planning time:" in line_lower:
                plan_time_ms = float(line_lower.split("planning time:")[1].strip().split()[0])
            if "execution time:" in line_lower:
                execution_time_ms = float(line_lower.split("execution time:")[1].strip().split()[0])

        if plan_time_ms is None or execution_time_ms is None:
            raise ValueError("Could not parse times from EXPLAIN output")

        wall = round(time.time() - t0, 2)
        return plan_time_ms, execution_time_ms, wall, "ok"

    except errors.QueryCanceled:
        wall = round(time.time() - t0, 2)
        conn.rollback()
        return None, None, wall, "timeout"

    except Exception as e:
        wall = round(time.time() - t0, 2)
        print(f"      FAILED — {type(e).__name__}: {e}")
        conn.rollback()
        return None, None, wall, "failed"


# -----------------------
# STATS / ROW BUILDING
# -----------------------

def build_row(query_no, pt_list, et_list, wall_list, timed_out, failed):
    valid_pt = [x for x in pt_list if isinstance(x, (int, float))]
    valid_et = [x for x in et_list if isinstance(x, (int, float))]

    avg_pt = sum(valid_pt) / len(valid_pt) if valid_pt else None
    median_pt = statistics.median(valid_pt) if valid_pt else None

    avg_et = sum(valid_et) / len(valid_et) if valid_et else None
    median_et = statistics.median(valid_et) if valid_et else None
    min_et = min(valid_et) if valid_et else None
    max_et = max(valid_et) if valid_et else None
    stdev_et = statistics.stdev(valid_et) if len(valid_et) >= 2 else None

    return (
        [query_no] + pt_list + et_list + wall_list
        + [avg_et, median_et, min_et, max_et, stdev_et, avg_pt, median_pt,
           len(valid_et), timed_out, failed]
    )


HEADER_SUFFIX = [
    "avg_e(ms)", "median_e(ms)", "min_e(ms)", "max_e(ms)", "stdev_e(ms)",
    "avg_pt(ms)", "median_pt(ms)",
    "n_valid_runs", "timed_out", "failed",
]


# -----------------------
# PER-QUERY PHASE RUNNERS
# -----------------------

def bring_postgres_to_normal_status(cursor):
    cursor.execute("SET ml_cardest_enabled = False;")
    cursor.execute("SET print_single_tbl_queries = False;")
    cursor.execute("RESET ml_cardest_fname;")
    cursor.execute("RESET query_no;")
    cursor.execute("RESET statement_timeout;")


def reset_session_state_for_new_query(cursor):
    bring_postgres_to_normal_status(cursor)


def run_baseline_phase(cursor, conn, stmt):
    """
    Runs baseline (pure Postgres estimator) up to RUNS_PER_QUERY times,
    stopping early on the first failure/timeout.

    IMPORTANT: predicates.txt is wiped (clear_predicates_file) before
    EVERY run, including any later run that might fail. So if run 1
    succeeds and run 2 then fails, predicates.txt would otherwise be
    left empty/partial from run 2's failed attempt -- not run 1's good
    data. To prevent that, we snapshot predicates.txt right after each
    successful run and restore that snapshot at the end, so downstream
    injection always uses the last successful run's predicates.
    """
    pt_list, et_list, wall_list = [], [], []
    timed_out = False
    failed = False
    any_success = False
    last_good_predicates = None

    for run in range(RUNS_PER_QUERY):
        cursor.execute(f"SET statement_timeout = {TIMEOUT_MS};")
        cursor.execute("SET ml_cardest_enabled = False;")
        cursor.execute("SET print_single_tbl_queries = True;")

        clear_predicates_file(PREDICATES_PATH)

        pt, et, wall, status = run_explain(cursor, conn, stmt)

        if status == "ok":
            pt_list.append(pt); et_list.append(et); wall_list.append(wall)
            any_success = True
            print(f"    baseline run {run + 1}: ok (e={et:.1f}ms, pt={pt:.1f}ms)")

            # snapshot predicates.txt immediately, before it can be
            # wiped by a subsequent (possibly failing) run
            if os.path.exists(PREDICATES_PATH):
                with open(PREDICATES_PATH, "r", encoding="utf-8") as pf:
                    last_good_predicates = pf.read()
        else:
            pt_list.append("timeout"); et_list.append("timeout"); wall_list.append(wall)
            print(f"    baseline run {run + 1}: {status}")
            if status == "timeout":
                timed_out = True
            else:
                failed = True
            remaining = RUNS_PER_QUERY - run - 1
            pt_list.extend(["timeout"] * remaining)
            et_list.extend(["timeout"] * remaining)
            wall_list.extend(["timeout"] * remaining)
            break

    # restore the last successful run's predicates.txt, in case the
    # loop ended on a failed/timed-out run that wiped/left it stale
    if last_good_predicates is not None:
        with open(PREDICATES_PATH, "w", encoding="utf-8") as pf:
            pf.write(last_good_predicates)
        os.chmod(PREDICATES_PATH, 0o777)

    return pt_list, et_list, wall_list, timed_out, failed, any_success


def run_injection_phase(cursor, conn, stmt):
    pt_list, et_list, wall_list = [], [], []
    timed_out = False
    failed = False

    for run in range(RUNS_PER_QUERY):
        cursor.execute(f"SET statement_timeout = {TIMEOUT_MS};")
        cursor.execute("SET print_single_tbl_queries = False;")
        cursor.execute("SET ml_cardest_enabled = True;")
        cursor.execute("SET query_no = 0;")
        cursor.execute(f"SET ml_cardest_fname = '{SELECTIVITIES_PATH}';")

        pt, et, wall, status = run_explain(cursor, conn, stmt)

        if status == "ok":
            pt_list.append(pt); et_list.append(et); wall_list.append(wall)
            print(f"    injected run {run + 1}: ok (e={et:.1f}ms, pt={pt:.1f}ms)")
        else:
            pt_list.append("timeout"); et_list.append("timeout"); wall_list.append(wall)
            print(f"    injected run {run + 1}: {status}")
            if status == "timeout":
                timed_out = True
            else:
                failed = True
            remaining = RUNS_PER_QUERY - run - 1
            pt_list.extend(["timeout"] * remaining)
            et_list.extend(["timeout"] * remaining)
            wall_list.extend(["timeout"] * remaining)
            break

    cursor.execute("SET print_single_tbl_queries = False;")
    return pt_list, et_list, wall_list, timed_out, failed


# -----------------------
# MAIN
# -----------------------

def print_pg_settings(cursor, label):
    print(f"\n--- PostgreSQL settings ({label}) ---")
    cursor.execute("""
        SELECT name, setting, source, context
        FROM pg_settings
        WHERE name IN (
            'print_single_tbl_queries', 'ml_cardest_enabled',
            'ml_cardest_fname', 'query_no', 'statement_timeout'
        )
        ORDER BY name;
    """)
    for row in cursor.fetchall():
        print(row)
    print("-----------------------------------\n")


def main():
    for path in (BASELINE_OUTPUT_CSV, INJECTED_OUTPUT_CSV):
        out_dir = os.path.dirname(path)
        if out_dir:
            os.makedirs(out_dir, exist_ok=True)

    with open(INPUT_SQL_FILE, "r", encoding="utf-8") as f:
        content = f.read()
    statements = split_statements(content)
    num_queries = len(statements)
    print(f"\nTOTAL QUERIES FOUND: {num_queries}\n")

    print("Loading selectivity lookup tables...")
    lookup = SelectivityLookup(INJECTION_FILES, INJECTION_FILE_TABLE_MAP)
    print()

    pt_cols = [f"pt{r+1}(ms)" for r in range(RUNS_PER_QUERY)]
    e_cols = [f"e{r+1}(ms)" for r in range(RUNS_PER_QUERY)]
    wall_cols = [f"wall{r+1}(s)" for r in range(RUNS_PER_QUERY)]
    header = ["Query No"] + pt_cols + e_cols + wall_cols + HEADER_SUFFIX

    conn = psycopg2.connect(**DB_CONFIG)
    conn.autocommit = True
    cursor = conn.cursor()

    baseline_rows = []
    injected_rows = []

    total_timeouts = 0
    total_failures = 0
    run_start_all = time.time()

    for i, stmt in enumerate(statements):
        print(f"[Query {i+1}/{num_queries}]")

        if not stmt.strip():
            continue

        # --- Reset everything before starting this query's baseline ---
        reset_session_state_for_new_query(cursor)

        # --- Phase 1: baseline, pure Postgres estimator ---
        b_pt, b_et, b_wall, b_timed_out, b_failed, baseline_ok = \
            run_baseline_phase(cursor, conn, stmt)
        if b_timed_out:
            total_timeouts += 1
        if b_failed:
            total_failures += 1

        # --- Bring Postgres back to normal status before setting up ---
        # --- injection: no leftover baseline GUCs, no logging active ---
        bring_postgres_to_normal_status(cursor)

        if not baseline_ok:
            print("    baseline never succeeded — attempting injection anyway.")

        # --- Phase 2: build selectivities.txt from predicates.txt ---
        # --- (from the last successful baseline run, preserved even  ---
        # ---  if a later baseline run failed and wiped predicates.txt) ---
        compute_selectivities(PREDICATES_PATH, SELECTIVITIES_PATH, lookup, stmt=stmt)

        # --- Phase 3: injection. run_injection_phase stops after the ---
        # --- first failed/timed-out run, so if injection run 1 fails, ---
        # --- run 2 is skipped and padded with "timeout".              ---
        j_pt, j_et, j_wall, j_timed_out, j_failed = \
            run_injection_phase(cursor, conn, stmt)
        if j_timed_out:
            total_timeouts += 1
        if j_failed:
            total_failures += 1

        # --- Bring Postgres back to normal status right after ---
        # --- injection finishes, before moving to the next query ---
        bring_postgres_to_normal_status(cursor)

        baseline_rows.append(build_row(i + 1, b_pt, b_et, b_wall, b_timed_out, b_failed))
        injected_rows.append(build_row(i + 1, j_pt, j_et, j_wall, j_timed_out, j_failed))

    bring_postgres_to_normal_status(cursor)
    lookup.summary()

    total_wall_all = time.time() - run_start_all
    print(f"\nTotal benchmark wall time: {total_wall_all/60:.1f} min")
    print(f"Timeouts: {total_timeouts}   Failures: {total_failures}")

    with open(BASELINE_OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(baseline_rows)

    with open(INJECTED_OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(injected_rows)
    os.chmod(INJECTED_OUTPUT_CSV, 0o777)

    cursor.close()
    conn.close()

    print("\n✅ Done.")
    print(f"   Total queries: {num_queries}")
    print(f"   Baseline CSV:  {BASELINE_OUTPUT_CSV}")
    print(f"   Injected CSV:  {INJECTED_OUTPUT_CSV}")


if __name__ == "__main__":
    main()
