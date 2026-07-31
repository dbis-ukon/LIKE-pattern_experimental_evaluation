SELECT co.name, COUNT(DISTINCT t.id) AS movies
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE (co.name LIKE '%c%P%u%io_' OR co.name LIKE 'C%Ent%ai%n_')
  AND t.season_nr = 3
  AND t.production_year BETWEEN 2013 AND 2014
GROUP BY co.name
ORDER BY movies DESC;
