# LIKE-Pattern Cardinality Estimation Benchmark (LCEB)

Cardinality estimation is a fundamental component of cost-based query optimization, as inaccurate estimates can lead to suboptimal execution plans. Estimating the cardinality of LIKE-queries is a particularly challenging subproblem, and an increasing number of LIKE-pattern cardinality estimation methods have recently been proposed, achieving high estimation accuracy. However, no benchmark or systematic study currently evaluates their impact on query optimization or quantifies the extent to which improved cardinality estimates translate into better execution performance. In this paper, we present a comprehensive experimental study of LIKE-pattern cardinality estimation methods from the perspective of query optimization in a real-world DBMS. We introduce the LIKE-Pattern Cardinality Estimation Benchmark (LCEB), consisting of query workloads derived from a real-world dataset, and integrate existing LIKE-pattern cardinality estimation methods into {PostgreSQL} and {DuckDB} to evaluate their practical effectiveness in improving query plan quality and execution performance. Our evaluation demonstrates that more accurate LIKE-predicate cardinality estimates do not necessarily translate into improved end-to-end query execution performance

## To Generate SQL Queries

We use SQLStorm to generate the SQL query workload for our benchmark. SQLStorm leverages Large Language Models (LLMs) to automatically generate diverse SQL queries from a given database schema. Please follow the setup instructions in the repository's README.md to run it.

| Method | Repository |
|--------|------------|
| SQLStorm | [github.com/SQL-Storm/SQLStorm](https://github.com/SQL-Storm/SQLStorm) |


We use SQLStorm's source code with 8 prompts (its 7 predefined prompts, P1–P7, plus one additional prompt we introduce for single-table query generation) to generate our sample SQL queries.

## How to Setup DBMS

### PostgreSQL 18.0

`postgres18_like_predicate_injection.patch` extends PostgreSQL 18.0's query optimizer to accept externally supplied selectivity estimates for single-relation restriction clauses (e.g. `LIKE`-predicates), and to log the selectivities PostgreSQL's own estimator would otherwise use.

#### Build

```bash
git clone https://github.com/postgres/postgres.git
cd postgres
git checkout REL_18_0
patch -p1 < postgres18_like_predicate_injection.patch
./configure --prefix=/usr/local/pgsql/18.0 --enable-depend --enable-cassert --enable-debug CFLAGS="-ggdb -O0"
make && sudo make install
echo 'export PATH=/usr/local/pgsql/18.0/bin:$PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/local/pgsql/18.0/lib/:$LD_LIBRARY_PATH' >> ~/.bashrc
source ~/.bashrc
initdb -D $PSQL_DATA_DIRECTORY
postgres -D $PSQL_DATA_DIRECTORY
```

#### Integration of Estimation into PostgreSQL

To enable PostgreSQL to use estimates from different cardinality estimation methods, you should trigger some knobs in the clients of PostgreSQL.

#### Get PostgreSQL Estimates

```sql
stats=# SET print_single_tbl_queries = True;
```

#### Selectivity Injection

```sql
stats=# SET ml_cardest_enabled = on;
stats=# SET query_no = 0;
stats=# SET ml_cardest_fname = '/absolute/path/to/selectivities.txt';
```

---

### DuckDB v1.6.0-dev11215

`duckdb_1.6.0_like_predicate_injection.patch` extends DuckDB to accept externally supplied selectivity estimates for `LIKE`-predicates, and reads them from a plain text file during query optimization.

#### Build

```bash
git clone https://github.com/duckdb/duckdb.git
cd duckdb
git checkout b95e49bf7a
patch -p1 < duckdb_1.6.0_like_predicate_injection.patch
mkdir -p build/release && cd build/release
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release ../..
cmake --build . --config Release
echo 'export PATH='"$(pwd)"':$PATH' >> ~/.bashrc
source ~/.bashrc
```

#### Selectivity Injection

The file is read from the current working directory by default, or from the path given in `DUCKDB_LIKE_SELECTIVITY_FILE` if set.

```bash
export DUCKDB_LIKE_SELECTIVITY_FILE=/absolute/path/to/like_selectivity.txt
duckdb test.db -c "EXPLAIN SELECT * FROM title WHERE title LIKE 'abc%';"
```

If no entry exists for a given pattern, DuckDB falls back to its own default selectivity estimate.


## To Run Cardinality Estimation Methods

For LBS, CLIQUE, and P-SPH, please use the source code we provide directly. For LPLM, SSCard, and Astrid, please use the source code available at the links below. To obtain estimates for `LIKE`-predicates, follow the instructions in each method's source code `README.md` and its respective paper.

### Source Code for LPLM, Astrid, SSCard

| Method | Repository |
|--------|------------|
| LPLM   | [github.com/dbis-ukon/lplm](https://github.com/dbis-ukon/lplm) |
| Astrid | [github.com/saravanan-thirumuruganathan/astrid-string-selectivity](https://github.com/saravanan-thirumuruganathan/astrid-string-selectivity) |
| SSCard | [github.com/marlcplhra/SSCard](https://github.com/marlcplhra/SSCard) |


## Integration of Cardinality Estimates into PostgreSQL/DuckDB

For each cardinality estimation method, prepare a method_column.txt file containing the LIKE-predicates evaluated by that method and their respective estimated selectivity, one pattern<TAB>selectivity entry per line. For example, LPLM_keyword.txt contains LPLM's estimated selectivities for LIKE-predicates over the keyword column.
