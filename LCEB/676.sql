SELECT t.title, k.keyword, t.production_year
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '(2011_06_21)'
  AND t.title NOT LIKE 'Won by _osing'
  AND t.kind_id = 1
  AND t.production_year >= 2011
  AND k.phonetic_code IS NOT NULL
  AND k.keyword NOT LIKE '_nnerm_tio_'
LIMIT 200;
