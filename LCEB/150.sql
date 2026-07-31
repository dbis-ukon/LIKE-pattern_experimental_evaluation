SELECT cn.name, t.title, t.production_year
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN title t ON t.id = ci.movie_id
WHERE cn.name LIKE '_alent_Jud_e 1'
  AND t.production_year >= 2011
  AND ci.nr_order <= 14
  AND t.kind_id IN (7, 3, 1)
ORDER BY t.production_year DESC;
