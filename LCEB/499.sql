SELECT akat.id, akat.title, akat.production_year, akat.kind_id,
       ci.person_id, cn.name AS character_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE akat.title LIKE 'House 3'
  AND cn.name LIKE 'Hyd%sect'
  AND ci.role_id IN (3, 2, 6, 4, 10);
