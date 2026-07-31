SELECT n.name, AVG(a.episode_nr) AS avg_episodes, MAX(a.production_year) AS last_year
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN aka_title a ON a.movie_id = ci.movie_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE n.name LIKE 'T%son'
  AND rt.role LIKE '%Cameo%'
  AND a.episode_nr >= 2
GROUP BY n.name
ORDER BY avg_episodes DESC;
