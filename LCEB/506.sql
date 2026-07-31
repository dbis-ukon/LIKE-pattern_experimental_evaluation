SELECT
    t.id,
    t.title,
    n.name,
    rt.role
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE t.title LIKE 'Les_f%d%c_né'
  AND n.name LIKE 'W%t%s%a_d'
  AND cn.name LIKE '%w_c_l%ct% %u%l%'
  AND rt.role LIKE '%actor%'
  AND n.gender = 'm'
  AND ci.nr_order <= 1
  AND t.production_year >= 2006;
