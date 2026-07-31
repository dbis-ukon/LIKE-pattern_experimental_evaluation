SELECT akat.movie_id, t.title, n.gender, SUM(akat.episode_nr) AS total_episodes, rt.role AS role_type
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE (cn.name LIKE 'S% _il_iam%' OR cn.name LIKE '_ü%p%m%')
  AND (n.name LIKE '%ar%m' OR n.name LIKE 'Ner_el')
  AND (t.title LIKE '% %t_r_ de%d%pa_s_ %q%' OR t.title LIKE 'Eve''s Motive')
GROUP BY akat.movie_id, t.title, n.gender, rt.role
ORDER BY total_episodes DESC;
