SELECT akat.id, akat.title, akat.production_year, akat.kind_id,
       ci.person_id, cn.name AS character_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE akat.title LIKE '_bente%erin'
  AND cn.name LIKE '%r%q%'
  AND ci.role_id = 7;
