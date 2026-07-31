SELECT
    n.name,
    AVG(a.episode_nr) AS avg_episodes
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN aka_title a ON a.movie_id = ci.movie_id
WHERE n.name LIKE '_al%omi%'
  AND a.production_year >= 1939
  AND a.season_nr = 1
GROUP BY n.name
ORDER BY avg_episodes DESC;
