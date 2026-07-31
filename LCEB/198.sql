SELECT
    n.name,
    COUNT(DISTINCT ci.movie_id) AS num_movies,
    MAX(a.episode_nr) AS max_episode
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN aka_title a ON a.movie_id = ci.movie_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE n.name LIKE '%b_o%'
  AND rt.role LIKE '%Supporting%'
  AND a.production_year >= 1968
  AND a.season_nr BETWEEN 4 AND 13
GROUP BY n.name
ORDER BY num_movies DESC;
