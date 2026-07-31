SELECT co.name, MIN(t.production_year) AS first_movie, MAX(t.production_year) AS last_movie
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE co.name LIKE 'Orphic F_lm'
  AND t.production_year IS NOT NULL
GROUP BY co.name
ORDER BY last_movie DESC;
