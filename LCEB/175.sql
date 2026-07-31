SELECT a.title, COUNT(DISTINCT mc.company_id) AS companies, AVG(a.production_year) AS avg_year
FROM aka_title a
JOIN movie_companies mc ON mc.movie_id = a.movie_id
JOIN company_name co ON co.id = mc.company_id
WHERE a.title LIKE '%''_u%a%' OR a.title LIKE 'Dob_o_ru%í ve_s_eh_'
  AND co.country_code = '[be]'
  AND mc.note LIKE '%Studio%'
GROUP BY a.title
ORDER BY companies DESC;
