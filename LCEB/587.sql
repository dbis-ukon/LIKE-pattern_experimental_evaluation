SELECT t.id, ci.person_role_id
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (k.keyword LIKE 'isolated-_ouse' OR k.keyword LIKE '_oli%-d%-%ri%')
  AND t.title LIKE '_ove_Y_ur Enem_'
  AND n.name LIKE '%m%'
  AND akat.title LIKE 'F_ust%z%ne'
  AND co.name LIKE 'S%my%t_d_os'
  AND cn.name LIKE 'H_npe_k%H%nd''s _i%'
  AND ci.person_role_id > 422365
  AND t.production_year >= 1998
  AND ci.role_id = 2
  AND mc.company_type_id = 2;
