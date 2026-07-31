SELECT cn.name AS character_name, t.season_nr, MIN(akat.episode_nr) AS first_episode, MAX(akat.episode_nr) AS last_episode
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE cn.name LIKE '%c%na%tém_in%'
  AND t.title LIKE 'Los reyes d_ la_p_sta'
GROUP BY cn.name, t.season_nr
ORDER BY t.season_nr, last_episode DESC;
