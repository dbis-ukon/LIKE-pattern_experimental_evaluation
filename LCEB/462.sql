SELECT n.id, n.name, n.imdb_id, n.gender,
       ci.role_id, cn.name AS character_name
FROM name n
JOIN cast_info ci ON n.imdb_id = ci.person_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE (n.name LIKE 'F%nc_r%Rui_h' OR n.name LIKE 'M%u%i')
  AND n.gender = 'm'
  AND n.imdb_id IS NOT NULL
  AND ci.nr_order <= 9;
