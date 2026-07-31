SELECT n.name, COUNT(DISTINCT t.id) AS films, AVG(t.production_year) AS avg_year, COUNT(DISTINCT k.id) AS kw_count
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE '_o%n%e%'
  AND t.kind_id IN (6, 1, 7)
  AND ci.role_id IN (2, 4, 1, 5, 10)
  AND t.episode_nr <= 30
  AND (k.keyword LIKE 'ye_low%y_')
  AND k.keyword NOT LIKE 'i%ort_l%'
  AND ci.nr_order IS NOT NULL
GROUP BY n.name
HAVING COUNT(DISTINCT t.id) > 2 AND COUNT(DISTINCT k.id) >= 1
ORDER BY films DESC, avg_year;
