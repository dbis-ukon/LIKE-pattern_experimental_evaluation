SELECT cn.name, co.name AS company_name, COUNT(DISTINCT t.id) AS movie_count
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN title t ON t.id = ci.movie_id
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE cn.name LIKE 'H%S%e%s%h'
  AND co.country_code = '[mx]'
  AND t.production_year BETWEEN 1997 AND 2008
  AND ci.nr_order <= 1
  AND t.kind_id IN (2, 7, 1, 6)
GROUP BY cn.name, co.name
ORDER BY movie_count DESC;
