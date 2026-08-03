"""
Enriches base SQL queries (e.g. from SQLStorm's generated JOB workload)
into more realistic PostgreSQL analytics queries by adding additional
WHERE-clause predicates via an LLM, following a strict set of structural,
type-consistency, and schema-safety rules. Each enriched query is then
passed through a second, self-review pass with the same model to catch
and fix common validity issues (e.g. OR blocks mixing numeric and text
predicates, duplicate/overlapping numeric ranges, unnecessary
parentheses) before being written to disk.

Usage:
    export OPENAI_API_KEY="your-key-here"
    python3 enrich_queries.py

Update the paths in the CONFIG section below before running.
"""
import os
import re
import time
import json
from pathlib import Path

from openai import OpenAI

# -----------------------
# CONFIG
# -----------------------

# API key is read from the environment - never hardcode a key in source
# that may be shared, committed, or published as supplemental material.
API_KEY = os.environ.get("OPENAI_API_KEY")
if not API_KEY:
    raise RuntimeError(
        "OPENAI_API_KEY environment variable is not set. "
        "Run `export OPENAI_API_KEY=your-key-here` before running this script."
    )

INPUT_DIR = Path("/path/to/SQLStorm/job/runnable")
OUTPUT_DIR = Path("/path/to/SQLStorm/job/enriched")
SCHEMA_FILE = Path("/path/to/SQLStorm/benchmark/benchmarks/job/job.dbschema.json")

OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

MODEL = "gpt-4o-mini"
RATE_LIMIT_SLEEP = 0.2

# -----------------------
# CLIENT + SCHEMA
# -----------------------

client = OpenAI(api_key=API_KEY)

schema = json.loads(SCHEMA_FILE.read_text())


def format_schema(schema_json: dict) -> str:
    """Formats the JSON database schema into a compact, LLM-readable
    "table_name: col1, col2, ..." text block, one line per table."""
    lines = []
    for table in schema_json["tables"]:
        cols = ", ".join(col["name"] for col in table["columns"])
        lines.append(f"{table['name']}: {cols}")
    return "\n".join(lines)


SCHEMA_TEXT = format_schema(schema)

# -----------------------
# Example PROMPTS
# -----------------------

SYSTEM_PROMPT = f"""
You are a SQL rewriting assistant.

You are GIVEN THE AUTHORITATIVE DATABASE SCHEMA below.
You MUST obey it strictly.

================= SCHEMA =================
{SCHEMA_TEXT}
==========================================

YOUR TASK:
Enrich SQL queries to make them realistic, runnable queries.

====================================================
STRICT STRUCTURAL RULES
====================================================
- Do NOT change SELECT, FROM, JOIN, GROUP BY, ORDER BY clauses
- Do NOT add, remove, or reorder tables
- Do NOT add subqueries, CTEs, or window functions
- ONLY enrich the WHERE clause of the FINAL SELECT
- Keep ALL original predicates exactly as they are
- Do NOT add a subquery as a predicate
- Do NOT use id columns as predicates
- Do NOT repeat existing predicates
- Never use IS NULL or IS NOT NULL more than 2 times
- Flatten OR / AND logic; avoid unnecessary parentheses
- Avoid trivial OR combinations
- Avoid ORs combining numeric and text predicates

====================================================
COLUMN-TYPE FIRST ENRICHMENT RULE
====================================================
When adding new predicates:
1. Numeric columns -> =, <, >, <=, >=, BETWEEN
2. Text columns -> = or LIKE
3 OR blocks must only combine predicates of the same type (text with text, numeric with numeric)
4. Always prefer numeric and text filters first

====================================================
SCHEMA & ALIAS SAFETY
====================================================
- Use ONLY columns that exist exactly in the schema
- Only from tables already joined in the query
- Match the table alias in the query
- NEVER invent columns

====================================================
COLUMN WHITELIST
====================================================
complete_cast:
- status_id

aka_title:
- production_year
- season_nr
- episode_nr
- note

title:
- production_year
- season_nr
- episode_nr
- series_years

company_name:
- name
- country_code

company_type:
- kind

movie_companies:
- note
- company_type_id

keyword:
- phonetic_code

cast_info:
- note
- nr_order

name / aka_name:
- gender
- name

movie_info / movie_info_idx:
- info
- note

====================================================
ALLOWED PREDICATES
====================================================
- Numeric columns -> =, <, >, <=, >=, BETWEEN
- Text columns -> =, LIKE
- IN / NOT IN -> meaningful subsets only
- IS NULL / IS NOT NULL are NEVER allowed more than 2 times
- Avoid trivial OR combinations and unnecessary parentheses
- Avoid repeating existing predicates
- Avoid ORs that mix numeric and text predicates

====================================================
LOGICAL CONSISTENCY
====================================================
- No contradictory predicates
- No duplicates
- Flatten OR blocks so each branch is meaningful
- Combine related conditions into single OR blocks
- Do not wrap single conditions in parentheses unnecessarily
- Tighten numeric ranges without conflicts

====================================================
ENRICHMENT DENSITY RULES
====================================================
- For 2+ joined tables:
  - Add >= 4 new predicates total
  - Use >= 2 distinct table aliases
  - Each alias must contribute >= 2 predicates
- For 3+ joined tables:
  - Add >= 6 new predicates
  - Use >= 3 distinct aliases
- Prefer numeric ranges first, then text filters
- Never use IS NULL / IS NOT NULL
- ORs must only combine predicates of the same type

====================================================
FAILURE CONDITIONS
====================================================
If enrichment cannot satisfy schema rules, type-first rules, or logical consistency:
-> RETURN THE QUERY UNCHANGED

====================================================
FINAL VALIDATION
====================================================
- Count new predicates
- Count distinct aliases used
- Verify all columns and aliases exist
- Verify OR blocks are meaningful and type-consistent
- Ensure PostgreSQL validity

====================================================
OUTPUT RULES
====================================================
- Do not put ```sql and ```
- Output ONLY the final SQL query
- No explanations, markdown, or comments
- No extra whitespace
"""

REVIEW_PROMPT = """
You are a SQL validation assistant specialized in PostgreSQL analytics queries.

Check the SQL query below for the following issues:
1. Query must be parsable and runnable by PostgreSQL.
2. OR conditions combining numeric and text predicates are invalid.
3. Duplicate or overlapping numeric ranges must be removed, e.g.
   AND a.production_year > 2000 AND a.production_year BETWEEN 2005 AND 2020;
4. Unnecessary parentheses should be removed.

====================================================
OUTPUT RULES
====================================================
- Do not put ```sql and ```
- Output ONLY the final SQL query
- No explanations, markdown, or comments
- No extra whitespace
"""


def extract_final_select(sql: str) -> str:
    """Currently a passthrough - trims whitespace only. Kept as a named
    step in the pipeline in case future versions need to isolate the
    final SELECT from a multi-statement input file."""
    return sql.strip()


def fix_enriched_sql(sql: str) -> str:
    """Lightweight, non-LLM post-processing safety net applied after
    enrichment: strips any IS [NOT] NULL the model may have added despite
    being instructed not to, removes single redundant wrapping
    parentheses, and de-duplicates any exact repeated lines."""
    sql = re.sub(r"\bIS\s+(NOT\s+)?NULL\b", "", sql, flags=re.IGNORECASE)
    sql = re.sub(r"\(\s*([^\(\)]+?)\s*\)", r"\1", sql)

    lines = sql.splitlines()
    seen = set()
    clean_lines = []
    for line in lines:
        norm = line.strip().lower()
        if norm not in seen and norm != "":
            clean_lines.append(line)
            seen.add(norm)
    return "\n".join(clean_lines)


def enrich_sql(sql: str) -> str:
    """Sends the base query to the model with SYSTEM_PROMPT, applies the
    lightweight post-processing safety net, and returns the enriched
    query text."""
    response = client.responses.create(
        model=MODEL,
        input=[
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": extract_final_select(sql)},
        ],
        max_output_tokens=1200,
    )
    enriched = response.output_text.strip()
    enriched = "\n".join(l for l in enriched.splitlines() if l.strip())
    enriched = fix_enriched_sql(enriched)
    return enriched


def review_sql_with_model(sql: str) -> str:
    """Second pass: asks the model to self-review and fix the enriched
    query against REVIEW_PROMPT's validity checks (type-mixed ORs,
    duplicate/overlapping ranges, unnecessary parentheses)."""
    response = client.responses.create(
        model=MODEL,
        input=[
            {"role": "system", "content": SYSTEM_PROMPT},
            {"role": "user", "content": REVIEW_PROMPT + sql},
        ],
        max_output_tokens=1200,
    )
    reviewed = response.output_text.strip()
    reviewed = "\n".join(l for l in reviewed.splitlines() if l.strip())
    return reviewed


def main():
    sql_files = sorted(INPUT_DIR.glob("*.sql"))
    print(f"Found {len(sql_files)} SQL files")

    for i, sql_file in enumerate(sql_files, start=1):
        print(f"[{i}/{len(sql_files)}] Processing {sql_file.name}")

        sql = sql_file.read_text().strip()
        if not sql:
            print("  Empty file, skipping")
            continue

        try:
            enriched_sql = enrich_sql(sql)
            enriched_sql = review_sql_with_model(enriched_sql)
        except Exception as e:
            print(f"  Enrichment failed, copying original ({e})")
            enriched_sql = "-- ENRICHMENT FAILED\n" + sql

        output_path = OUTPUT_DIR / sql_file.name
        output_path.write_text(enriched_sql + "\n")

        time.sleep(RATE_LIMIT_SLEEP)

    print("All queries processed.")


if __name__ == "__main__":
    main()
