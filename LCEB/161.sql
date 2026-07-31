SELECT n.name, COUNT(DISTINCT mc.company_id) AS companies
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN movie_companies mc ON mc.movie_id = ci.movie_id
JOIN company_name co ON co.id = mc.company_id
WHERE n.name LIKE '%n_v_ %n%i%'
  AND co.country_code = '[hr]'
  AND mc.note LIKE '%Studio%'
  AND n.gender = 'm'
GROUP BY n.name
ORDER BY companies DESC;
