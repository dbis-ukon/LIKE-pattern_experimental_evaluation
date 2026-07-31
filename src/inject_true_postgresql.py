import os
import csv
import time
import statistics
import psycopg2
from psycopg2 import errors
import re


# -----------------------
# CONFIG
# -----------------------

INPUT_SQL_FILE = "/home/mehmet/Downloads/SQLStorm-master/v1.0/job/final_all/full_replaced_run_lplm_final_700_2.sql"

BASELINE_OUTPUT_CSV = "postgres_query_timings_withoutdiscard_lplmtrue2.csv"
INJECTED_OUTPUT_CSV = "postgres_query_timings_injected_card_lplmtrue2.csv"
PREDICATES_PATH = os.path.abspath("predicates.txt")
SELECTIVITIES_PATH = os.path.abspath("selectivities.txt")


ALLOWED_COLUMNS = {
    ("name", "name"),
    ("title", "title"),
    ("aka_title", "title"),
    ("company_name", "name"),
    ("char_name", "name"),
    ("keyword", "keyword"),
}


def load_queries(path):
    with open(path, encoding="utf-8") as f:
        return f.read()


_RESERVED_ALIASES = {
    "ON", "WHERE", "GROUP", "ORDER", "HAVING", "LIMIT",
    "UNION", "EXCEPT", "INTERSECT", "AS", "USING",
}


def extract_alias_map(sql):
    """
    Extract:
        FROM title t
        JOIN company_name c

    Returns:
        {
            "t": "title",
            "c": "company_name"
        }

    Assumes: FROM introduces exactly one table; all other tables
    are introduced via JOIN (no comma-joins).

    IMPORTANT: this must always be called on a SINGLE statement, never
    on the whole multi-query file -- otherwise an alias letter reused
    for a different table in a later query silently overwrites the
    earlier (correct) mapping for that alias.
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


# FIX #2: allow an optional "NOT" before LIKE, so "c.name NOT LIKE '...'"
# is no longer silently invisible to the ground-truth lookup builder.
_LIKE_PRED_RE = re.compile(
    r"""
    ([a-zA-Z_][a-zA-Z0-9_]*)
    \.
    ([a-zA-Z_][a-zA-Z0-9_]*)
    \s+
    (?:NOT\s+)?LIKE
    \s*
    ['"]([^'"]+)['"]
    """,
    re.IGNORECASE | re.VERBOSE
)


_LIKE_START_RE = re.compile(
    r"""([a-zA-Z_][a-zA-Z0-9_]*)\.([a-zA-Z_][a-zA-Z0-9_]*)\s+(?:NOT\s+)?LIKE\s*'""",
    re.IGNORECASE
)


def extract_like_predicates(stmt):
    """
    Extract only predicates like:

        alias.column LIKE 'pattern'
        alias.column NOT LIKE 'pattern'

    Correctly handles a doubled '' inside the pattern as an escaped
    literal single quote (e.g. 'k_l%''%tr_p_y' -> pattern k_l%'%tr_p_y),
    matching the same escaping rule split_statements() already uses for
    splitting the whole SQL file. The previous regex-based version used
    a [^'"]+ character class that stopped at the FIRST embedded quote,
    silently truncating any pattern containing an escaped apostrophe.
    """
    aliases = extract_alias_map(stmt)
    predicates = []
    n = len(stmt)

    for m in _LIKE_START_RE.finditer(stmt):
        alias, column = m.group(1), m.group(2)
        i = m.end()  # position right after the opening quote
        chars = []
        while i < n:
            ch = stmt[i]
            if ch == "'":
                if i + 1 < n and stmt[i + 1] == "'":
                    chars.append("'")   # escaped '' -> literal '
                    i += 2
                    continue
                else:
                    break  # real closing quote
            chars.append(ch)
            i += 1
        pattern = "".join(chars)

        table = aliases.get(alias)
        if table is None:
            continue
        if (table, column) not in ALLOWED_COLUMNS:
            continue

        predicates.append((table, column, pattern))

    return predicates

def get_total_rows(cur, table, column):
    """
    FIX #3: count of ALL rows in the table -- this must match the
    denominator PostgreSQL's own cost model uses (rel->tuples, i.e. the
    table's total row count), not just the rows where `column` happens
    to be non-null. The previous "WHERE column IS NOT NULL" version
    systematically inflated selectivity for any column containing nulls.
    """
    cur.execute(f"SELECT COUNT(*) FROM {table};")
    return cur.fetchone()[0]


def get_matching_rows(cur, table, column, pattern):
    cur.execute(
        f"""
        SELECT COUNT(*)
        FROM {table}
        WHERE {column} LIKE %s
        """,
        (pattern,)
    )
    return cur.fetchone()[0]


def load_selectivity_lookup(statements):
    """
    Returns:
        {
            (table, column, pattern): selectivity_float,
            ...
        }

    Keyed by the FULL (table, column, pattern) triple -- not just the
    pattern -- so that two predicates with the same LIKE pattern on
    different columns (e.g. t.title LIKE '%love%' and n.name LIKE
    '%love%'), or the same alias letter reused for different tables
    across different queries, never collide or overwrite each other.

    FIX #1: `statements` is now the list of INDIVIDUAL queries (already
    split), and alias resolution happens ONCE PER STATEMENT inside the
    loop below -- not once globally across the entire workload file.
    This is what actually prevents alias collisions between queries.
    """
    conn = psycopg2.connect(**DB_CONFIG)
    try:
        cur = conn.cursor()
        total_cache = {}
        selectivity_lookup = {}

        for stmt in statements:
            # Alias map (and therefore table resolution) is computed
            # fresh, per statement -- this is the fix.
            predicates = extract_like_predicates(stmt)

            for table, column, pattern in predicates:
                key = (table, column, pattern)
                if key in selectivity_lookup:
                    continue

                total_key = (table, column)
                if total_key not in total_cache:
                    total_cache[total_key] = get_total_rows(cur, table, column)
                total = total_cache[total_key]

                matched = get_matching_rows(cur, table, column, pattern)

                # Always store as float for a consistent type.
                selectivity_lookup[key] = (
                    matched / total if total > 0 else 0.0
                )

        cur.close()

    finally:
        conn.close()

    print(f"Loaded {len(selectivity_lookup)} (table, column, pattern) selectivities.")
    return selectivity_lookup


TIMEOUT_MS = 3 * 60_000       # 3 minutes
RUNS_PER_QUERY = 2            # up to 2 full passes per phase -> report
                               # median/min/max/stdev, not just a single value.

DB_CONFIG = {
    "host": "localhost",
    "port": 5432,
    "dbname": "inject_db",
    "user": "mehmet",
    "password": "postgres",
}
# -----------------------
# SQL SPLITTING HELPERS
# -----------------------

def is_real_query(s):
    """Check that the statement has at least one non-comment, non-empty line."""
    s = s.strip()
    if not s:
        return False
    lines = [
        line for line in s.splitlines()
        if line.strip() and not line.strip().startswith("--")
    ]
    return bool(lines)


def split_statements(content: str) -> list:
    """
    Split SQL content into individual statements by semicolon,
    ignoring semicolons inside string literals (handles '' escaped quotes).
    """
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
                    buf.append(content[i + 1])
                    i += 2
                    continue
                in_string = False
            i += 1
            continue

        if ch == "'":
            in_string = True
            buf.append(ch)
            i += 1
            continue

        if ch == ";":
            stmt = "".join(buf).strip()
            if is_real_query(stmt):
                statements.append(stmt)
            buf = []
            i += 1
            continue

        buf.append(ch)
        i += 1

    tail = "".join(buf).strip()
    if is_real_query(tail):
        statements.append(tail)

    return statements


# -----------------------
# SELECTIVITY INJECTION HELPERS
# -----------------------

# Matches a predicates.txt LHS like:
#   k.keyword ~~ '%dove-award%'
#   c.name !~~ '%foo%'
_PRED_LIKE_RE = re.compile(
    r"""
    ^\s*
    ([a-zA-Z_][a-zA-Z0-9_]*)     # alias
    \.
    ([a-zA-Z_][a-zA-Z0-9_]*)     # column
    \s*
    (!?~~)                       # operator: ~~ (LIKE) or !~~ (NOT LIKE)
    \s*
    '(.*)'                       # pattern, greedy to the LAST quote on the line
    \s*$
    """,
    re.VERBOSE
)


def compute_selectivities(predicates_path: str, selectivities_path: str,
                           lookup: dict, stmt: str = None):
    """
    Reads predicates.txt (lines like "alias.column OP value,pg_selectivity")
    and writes selectivities.txt with one selectivity per line, in the
    same order.

    For LIKE / NOT LIKE predicates whose alias resolves (via THIS
    statement's own alias map) to a (table, column) in ALLOWED_COLUMNS,
    and whose (table, column, pattern) triple exists in `lookup`, the
    ground-truth selectivity computed in load_selectivity_lookup() is
    used instead of Postgres's own estimate.

    Every other predicate (non-LIKE, unresolved alias, or a LIKE pattern
    missing from `lookup`) falls back to Postgres's own selectivity
    value (the value already present in predicates.txt).
    """

    stmt_lower = stmt.lower() if stmt else None
    alias_to_table = extract_alias_map(stmt) if stmt else {}

    fallback_count = 0
    hit_count = 0
    total_lines = 0

    with open(selectivities_path, "w") as newfile:
        if os.path.exists(predicates_path):
            with open(predicates_path) as f:
                for raw_line in f:
                    line = raw_line.strip()
                    if not line or ',' not in line:
                        continue
                    total_lines += 1

                    # Split off the trailing Postgres-computed selectivity.
                    # Use rpartition (splits on the LAST comma) so that a
                    # comma inside the LIKE pattern itself doesn't break
                    # the split.
                    lhs, _, pg_selectivity = line.rpartition(',')
                    lhs = lhs.strip()
                    pg_selectivity = pg_selectivity.strip()

                    # Skip predicates that don't belong to this query
                    # (internal catalog lookup noise).
                    if stmt_lower and '.' in lhs:
                        alias = lhs.split('.', 1)[0].strip().lower()
                        if f"{alias}." not in stmt_lower:
                            continue

                    # Default: use Postgres's own selectivity for this predicate.
                    k = pg_selectivity

                    m = _PRED_LIKE_RE.match(lhs)
                    if m:
                        p_alias, column, op, pattern = m.groups()
                        table = alias_to_table.get(p_alias)

                        if table is not None:
                            lookup_key = (table, column, pattern)
                            if lookup_key in lookup:
                                val = float(lookup[lookup_key])
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
        print(
            f"    [compute_selectivities] {hit_count} matched lookup, "
            f"{fallback_count}/{total_lines} fell back to Postgres estimate "
            f"(unresolved alias or pattern not in lookup)."
        )

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
    """
    Runs EXPLAIN (ANALYZE, BUFFERS) for stmt on the given cursor.
    Returns (plan_time_ms, execution_time_ms, wall_seconds, status) where
    status is one of "ok", "timeout", "failed".
    """
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
                plan_time_ms = float(
                    line_lower.split("planning time:")[1].strip().split()[0]
                )
            if "execution time:" in line_lower:
                execution_time_ms = float(
                    line_lower.split("execution time:")[1].strip().split()[0]
                )

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
            pt_list.append(pt)
            et_list.append(et)
            wall_list.append(wall)
            any_success = True
            print(f"    baseline run {run + 1}: ok (e={et:.1f}ms, pt={pt:.1f}ms)")

            # snapshot predicates.txt immediately, before it can be
            # wiped by a subsequent (possibly failing) run
            if os.path.exists(PREDICATES_PATH):
                with open(PREDICATES_PATH, "r", encoding="utf-8") as pf:
                    last_good_predicates = pf.read()
        else:
            pt_list.append("timeout")
            et_list.append("timeout")
            wall_list.append(wall)
            print(f"    baseline run {run + 1}: {status}")
            if status == "timeout":
                timed_out = True
            else:
                failed = True
            # Stop retrying baseline; pad remaining runs as timeouts.
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
            pt_list.append(pt)
            et_list.append(et)
            wall_list.append(wall)
            print(f"    injected run {run + 1}: ok (e={et:.1f}ms, pt={pt:.1f}ms)")
        else:
            pt_list.append("timeout")
            et_list.append("timeout")
            wall_list.append(wall)
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
            'print_single_tbl_queries',
            'ml_cardest_enabled',
            'ml_cardest_fname',
            'query_no',
            'statement_timeout'
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
    # FIX #1: pass the already-split list of individual statements, not
    # the raw file content, so alias resolution happens per-query inside
    # load_selectivity_lookup.
    lookup = load_selectivity_lookup(statements)
    print(f"  {len(lookup)} lookup entries loaded.\n")

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
        if i != 5660:
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
    
            compute_selectivities(PREDICATES_PATH, SELECTIVITIES_PATH, lookup, stmt=stmt)
    
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
        else:
            print('bye')

    # --- Reset session GUCs so the connection is left in a clean state ---
    bring_postgres_to_normal_status(cursor)

    total_wall_all = time.time() - run_start_all
    print(f"\nTotal benchmark wall time: {total_wall_all/60:.1f} min")
    print(f"Timeouts: {total_timeouts}   Failures: {total_failures}")

    with open(BASELINE_OUTPUT_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(header)
        writer.writerows(baseline_rows)
    #os.chmod(BASELINE_OUTPUT_CSV, 0o777)

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
