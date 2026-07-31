SELECT  cn.name AS character_name, MAX(akat.production_year) AS latest_year, rt.role AS role_type
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN title t ON akat.movie_id = t.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE (cn.name LIKE '% _a_Ra_' OR cn.name LIKE 'Katy Hensel')
  AND (t.title LIKE 'Gree_land''s Icy Mountains' OR t.title LIKE '_enyes _''%entita_')
  AND n.gender = 'f'
GROUP BY cn.name, rt.role
ORDER BY latest_year DESC;
