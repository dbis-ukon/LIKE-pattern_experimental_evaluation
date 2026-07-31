SELECT co.name, COUNT(*) AS total_movies
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE co.name LIKE 'D%b_i%Fi_m_'
  AND t.season_nr = 6
  AND t.production_year BETWEEN 1989 AND 2009
GROUP BY co.name
ORDER BY total_movies DESC;
