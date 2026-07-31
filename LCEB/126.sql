SELECT co.name, COUNT(DISTINCT t.id) AS movie_count
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE (co.name LIKE '%Pro%c_i%' OR co.name LIKE 'U%n_C_e%ive')
  AND co.country_code = '[us]'
  AND t.production_year BETWEEN 1913 AND 2011
GROUP BY co.name
ORDER BY movie_count DESC;
