SELECT t.title, k.keyword, t.production_year
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.kind_id IN (7, 1, 3)
  AND t.title LIKE 'Mi_sin_ Person'
  AND k.keyword LIKE 'centur_'
  AND t.episode_nr <= 8
ORDER BY t.production_year DESC
LIMIT 100;
