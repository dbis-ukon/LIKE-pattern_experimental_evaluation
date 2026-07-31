SELECT
    n.name,
    COUNT(DISTINCT co.id) AS companies_worked
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN movie_companies mc ON mc.movie_id = ci.movie_id
JOIN company_name co ON co.id = mc.company_id
WHERE n.name LIKE '%w%o%'
  AND n.gender = 'f'
  AND mc.note LIKE '%Production%'
  AND co.country_code = '[de]'
GROUP BY n.name
ORDER BY companies_worked DESC;
