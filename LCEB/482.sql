SELECT c.id, c.name, c.country_code, c.md5sum,
       mc.movie_id, ci.person_id, cn.name AS character_name
FROM company_name c
JOIN movie_companies mc ON c.id = mc.company_id
JOIN cast_info ci ON mc.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE c.name LIKE '_o%s I%'
  AND cn.name LIKE 'Mi_h%l''s A_nt'
  AND mc.company_type_id = 1;
