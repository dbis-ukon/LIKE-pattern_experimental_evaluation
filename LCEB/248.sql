SELECT akat.movie_id, t.title, n.gender, SUM(akat.episode_nr) AS total_episodes
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE cn.name LIKE 'B_n_i_ C_l_i_s'
  AND t.title LIKE 'Posilovna'
GROUP BY akat.movie_id, t.title, n.gender
ORDER BY total_episodes DESC;
