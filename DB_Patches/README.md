
# PostgreSQL 18.0 — LIKE-Predicate Selectivity Injection

postgres18_like_predicate_injection.patch extends PostgreSQL 18.0's query optimizer to accept externally
supplied selectivity estimates for single-relation restriction clauses
(e.g. `LIKE`-predicates), and to log the selectivities PostgreSQL's own estimator would otherwise use.

## Build

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

## Integration of Estimation into PostgreSQL

To enable PostgreSQL to use estimates from different cardinality estimation methods, you should trigger some knobs in the clients of PostgreSQL

## Get PostgreSQL estimates
```sql
stats=# SET print_single_tbl_queries = True;
```
## Selectivity Injection

```sql
stats=# SET ml_cardest_enabled = on;
stats=# SET query_no = 0;
stats=# SET ml_cardest_fname = '/absolute/path/to/selectivities.txt';
```
# DuckDB v1.6.0-dev11215 — LIKE-Predicate Selectivity Injection

This patch extends DuckDB to accept externally supplied selectivity
estimates for `LIKE`-predicates, and reads them from a plain text file
during query optimization.

## Build

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
