SELECT t.title, COUNT(DISTINCT mc.company_id) AS companies
FROM title t
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE t.title LIKE 'Di_ %er%o_ Deut%-O_tafr%'
  AND co.country_code = '[us]'
  AND t.production_year BETWEEN 1958 AND 2008
  AND t.kind_id IN (1, 7, 4)
GROUP BY t.title
ORDER BY companies DESC;
