SELECT n.name, COUNT(DISTINCT t.id) AS films, AVG(t.production_year) AS avg_year, COUNT(DISTINCT k.id) AS kw_count
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE '_a%so%r_'
  AND k.keyword LIKE '%rth_d%e%n'
  AND k.phonetic_code IS NOT NULL
  AND ci.role_id IN (1, 9, 10, 2, 3)
  AND t.production_year <= 2012
GROUP BY n.name
HAVING COUNT(DISTINCT t.id) > 3 AND COUNT(DISTINCT k.id) >= 1
ORDER BY films DESC, avg_year;
