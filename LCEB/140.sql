SELECT t.title, MIN(t.production_year) AS first_year, MAX(t.production_year) AS last_year
FROM title t
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE t.title LIKE '% d%A%o%a%a% %d%a'
  AND co.country_code = '[us]'
  AND t.production_year >= 1995
  AND t.kind_id IN (1, 3, 6, 7, 4)
GROUP BY t.title
ORDER BY last_year DESC;
