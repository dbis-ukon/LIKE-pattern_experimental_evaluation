SELECT n.name, COUNT(DISTINCT t.id) AS films, AVG(t.production_year) AS avg_year, COUNT(DISTINCT k.id) AS kw_count
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE k.keyword LIKE '%han%n'
  AND ci.role_id IN (5, 10, 2, 1, 3)
  AND n.name LIKE '_vruj'
  AND t.kind_id IN (7, 1, 3)
  AND t.season_nr IS NULL
  AND ci.nr_order <= 0
GROUP BY n.name
HAVING COUNT(DISTINCT t.id) > 4 AND COUNT(DISTINCT k.id) >= 1
ORDER BY films DESC, avg_year;
