SELECT co.name, cn.name AS character_name, COUNT(DISTINCT t.id) AS movie_count
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
JOIN cast_info ci ON ci.movie_id = t.id
JOIN char_name cn ON cn.id = ci.person_id
WHERE co.name LIKE 'W%x%d%'
  AND cn.name LIKE '%c%n%'
  AND t.production_year BETWEEN 1987 AND 1998
  AND ci.nr_order <= 19
GROUP BY co.name, cn.name
ORDER BY movie_count DESC;
