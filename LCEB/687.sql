SELECT n1.name AS director, n2.name AS actor, COUNT(DISTINCT t.id) AS n_collabs
FROM title t
JOIN cast_info ci1 ON t.id = ci1.movie_id
JOIN cast_info ci2 ON t.id = ci2.movie_id
JOIN role_type rt1 ON ci1.role_id = rt1.id
JOIN role_type rt2 ON ci2.role_id = rt2.id
JOIN name n1 ON ci1.person_id = n1.id
JOIN name n2 ON ci2.person_id = n2.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE rt1.role = 'writer'
  AND rt2.role IN ('actress', 'actor', 'cinematographer', 'writer', 'miscellaneous crew')
  AND n2.name LIKE '%Ma%m'
  AND n1.name NOT LIKE 'Rodri%ez'
  AND t.title LIKE '% t_e L%d_r'
  AND k.keyword LIKE 'lo%r-body'
  AND ci2.nr_order <= 18
  AND ci2.nr_order IS NOT NULL
  AND n1.gender IS NOT NULL
  AND n2.gender IN ('m', 'f')
  AND t.kind_id IN (2, 7, 1, 3)
  AND n1.imdb_id IS NOT NULL
GROUP BY n1.name, n2.name
HAVING COUNT(DISTINCT t.id) >= 2
ORDER BY n_collabs DESC
LIMIT 30;
