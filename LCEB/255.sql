SELECT akat.movie_id, t.title, n.gender, SUM(akat.episode_nr) AS total_episodes
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE (cn.name LIKE '%rle_s' OR cn.name LIKE 'Mason DePa_l')
  AND (n.name LIKE 'Pi_culli%Rober%' OR n.name LIKE 'Garín')
  AND (t.title LIKE '(_1.46_' OR t.title LIKE '%3-_4_')
GROUP BY akat.movie_id, t.title, n.gender
ORDER BY total_episodes DESC;
