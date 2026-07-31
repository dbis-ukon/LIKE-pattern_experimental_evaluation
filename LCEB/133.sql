SELECT co.name, MIN(t.production_year) AS first_year, MAX(t.production_year) AS last_year, COUNT(DISTINCT t.id) AS total_movies
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE co.name LIKE '%H%d%'
  AND t.production_year BETWEEN 1907 AND 2013
GROUP BY co.name
ORDER BY last_year DESC;
