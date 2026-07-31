SELECT n.name, COUNT(DISTINCT ci.movie_id) AS num_movies, MAX(a.episode_nr) AS max_episode
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN aka_title a ON a.movie_id = ci.movie_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE n.name LIKE 'D%udog_u%Bu_ak' OR n.name LIKE '%s% _o_n_'
  AND rt.role LIKE '%Supporting%'
  AND a.production_year >= 1945
  AND a.season_nr BETWEEN 1 AND 36
GROUP BY n.name
ORDER BY num_movies DESC;
