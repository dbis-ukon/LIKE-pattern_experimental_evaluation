SELECT c.id, c.name, c.country_code, c.md5sum,
       mc.movie_id, ci.person_id, cn.name AS character_name
FROM company_name c
JOIN movie_companies mc ON c.id = mc.company_id
JOIN cast_info ci ON mc.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE c.name LIKE '%H%.'
  AND cn.name LIKE 'M_l%v%C%'
  AND mc.company_type_id IN (1, 2);
