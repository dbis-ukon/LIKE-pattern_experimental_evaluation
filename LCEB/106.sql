SELECT cn.name, MIN(t.production_year) AS first_movie, MAX(t.production_year) AS last_movie, COUNT(DISTINCT ci.movie_id) AS movie_count
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
WHERE cn.name LIKE 'Him% - %t_r_s%e_'
  AND (t.season_nr BETWEEN 1 AND 1 OR t.episode_nr <= 1)
  AND t.production_year >= 2012
  AND ci.nr_order <= 12
GROUP BY cn.name
ORDER BY last_movie DESC;
