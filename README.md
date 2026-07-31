# LIKE-Pattern Cardinality Estimation Benchmark (LCEB)

Cardinality estimation is a fundamental component of cost-based query optimization, as inaccurate estimates can lead to suboptimal execution plans. Estimating the cardinality of LIKE-queries is a particularly challenging subproblem, and an increasing number of LIKE-pattern cardinality estimation methods have recently been proposed, achieving high estimation accuracy. However, no benchmark or systematic study currently evaluates their impact on query optimization or quantifies the extent to which improved cardinality estimates translate into better execution performance. In this paper, we present a comprehensive experimental study of LIKE-pattern cardinality estimation methods from the perspective of query optimization in a real-world DBMS. We introduce the LIKE-Pattern Cardinality Estimation Benchmark (LCEB), consisting of query workloads derived from a real-world dataset, and integrate existing LIKE-pattern cardinality estimation methods into {PostgreSQL} and {DuckDB} to evaluate their practical effectiveness in improving query plan quality and execution performance. Our evaluation demonstrates that more accurate LIKE-predicate cardinality estimates do not necessarily translate into improved end-to-end query execution performance

### To generate SQL Queries

| Method | Repository |
|--------|------------|
| SQL Storm    | [[github.com/dbis-ukon/lplm](https://github.com/dbis-ukon/lplm) ](https://github.com/SQL-Storm/SQLStorm)|
