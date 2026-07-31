SELECT co.name, COUNT(DISTINCT t.id) AS movies, MIN(t.production_year) AS first_yr
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE mc.company_type_id IN (2, 1)
  AND t.title LIKE 'Ut%ie hi%er Ma%n'
  AND co.country_code = '[us]'
  AND t.kind_id = 7
  AND co.name LIKE 'C%ature%i%s'
  AND t.production_year >= 2007
GROUP BY co.name
HAVING COUNT(DISTINCT t.id) > 2
ORDER BY movies DESC;
