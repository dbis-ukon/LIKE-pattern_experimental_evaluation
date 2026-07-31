SELECT akat.id, akat.title, akat.production_year, akat.kind_id,
       ci.person_id, cn.name AS character_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE akat.title LIKE '%e_Rec%h%'
  AND cn.name LIKE 'Guy P_ay_ng Char_des'
  AND ci.role_id IN (9, 5, 3, 2, 1);
