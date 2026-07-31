SELECT t.title, k.keyword, t.production_year
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.kind_id IN (1, 7)
  AND t.season_nr IS NULL
  AND (t.title LIKE '(_7%55_' OR t.title LIKE 'F%hy%ness')
  AND t.title NOT LIKE 'Tracey Ullman'
  AND t.production_year BETWEEN 2007 AND 2008
  AND k.keyword NOT LIKE 'c_int_roc_well'
LIMIT 200;
