SELECT t.id, ci.person_role_id
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE (k.keyword LIKE 'h%r' or k.keyword LIKE 'coffee-table')
  AND t.title LIKE 'Rea_l_'
  AND n.name LIKE 'S_lvsku_t'
  AND ci.person_role_id > 2373
  AND t.production_year >= 2002
  AND ci.role_id = 1;
