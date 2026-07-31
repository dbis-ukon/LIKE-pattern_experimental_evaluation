SELECT n.name, AVG(a.episode_nr) AS avg_episodes
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN aka_title a ON a.movie_id = ci.movie_id
WHERE n.name LIKE '%n%g' OR n.name LIKE '%d%'
  AND a.season_nr = 2
GROUP BY n.name
ORDER BY avg_episodes DESC;
