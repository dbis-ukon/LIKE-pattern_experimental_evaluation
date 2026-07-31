SELECT t.series_years, AVG(akat.episode_nr) AS avg_episodes
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE t.title LIKE '(#38%0_)'
  AND n.name LIKE 'Ha_wa% T_e%a'
GROUP BY t.series_years
ORDER BY avg_episodes DESC;
