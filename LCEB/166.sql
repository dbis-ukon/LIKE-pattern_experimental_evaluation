SELECT a.title, COUNT(DISTINCT co.id) AS companies
FROM aka_title a
JOIN movie_companies mc ON mc.movie_id = a.movie_id
JOIN company_name co ON co.id = mc.company_id
WHERE a.title LIKE 'E_i%T%os%i%e% %r % _c_a_'
  AND co.country_code = '[us]'
  AND mc.note LIKE '%Studio%'
  AND a.production_year BETWEEN 1964 AND 2006
GROUP BY a.title
ORDER BY companies DESC;
