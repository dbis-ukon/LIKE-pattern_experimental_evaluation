SELECT cn.name, co.name AS company_name, COUNT(DISTINCT t.id) AS movies
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE cn.name LIKE '%g%e%f_'
  AND co.country_code = '[us]'
  AND t.production_year BETWEEN 1907 AND 1995
  AND ci.nr_order <= 8
GROUP BY cn.name, co.name
ORDER BY movies DESC;
