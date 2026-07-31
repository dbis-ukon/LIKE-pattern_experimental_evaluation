SELECT cn.name, MIN(t.production_year) AS first_year, MAX(t.production_year) AS last_year, COUNT(DISTINCT ci.movie_id) AS movies
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
WHERE cn.name LIKE '_e%own'
  AND t.season_nr = 15
  AND t.production_year BETWEEN 1986 AND 2012
  AND ci.nr_order <= 2
GROUP BY cn.name
ORDER BY last_year DESC;
