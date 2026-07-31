SELECT t.series_years, AVG(akat.episode_nr) AS avg_episodes, k.keyword AS top_keyword
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (t.title LIKE '%y%n_' OR t.title LIKE '_ce_D%am_')
  AND (n.name LIKE '_leta%Val' OR n.name LIKE 'H_r_is%An%n_')
GROUP BY t.series_years, k.keyword
ORDER BY avg_episodes DESC;
