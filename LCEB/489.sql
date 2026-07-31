SELECT akat.id, akat.title, akat.production_year, akat.kind_id,
       mc.company_id, c.name AS company_name, ci.person_id, cn.name AS character_name
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE akat.title LIKE 'U%n%o%e%o% _hi% R_i%'
  AND ci.role_id = 3
  AND mc.company_type_id = 2;
