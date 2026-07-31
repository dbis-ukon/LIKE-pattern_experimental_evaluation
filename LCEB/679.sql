SELECT t.title, k.keyword, t.production_year
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.kind_id IN (2, 1, 7)
  AND t.season_nr IS NULL
  AND (t.title LIKE 'S_t. K%u_ima_ N.Y%D_' OR t.title LIKE 'C_rl_ _ox')
  AND t.title NOT LIKE '(#1.4463)'
  AND t.production_year BETWEEN 1963 AND 2011
  AND k.keyword NOT LIKE 'soul_leaves-body';
