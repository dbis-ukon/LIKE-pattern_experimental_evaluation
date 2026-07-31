SELECT t.id, mc.note
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'le_ve-of-absence'
  AND (t.title LIKE 'Scoop_o_ the _entury/_oxing Edw_rd' OR t.title LIKE '(2006-06-28)')
  AND n.name LIKE '_ig% M%i_'
  AND akat.title LIKE '%li%c_e_ %E%i%l_t'
  AND co.name LIKE '_el%n%e_'
  AND cn.name LIKE 'Fem_en%l_zi_t'
  AND mc.note LIKE '%presents%'
  AND t.production_year >= 1951
  AND n.gender = 'f'
  AND ci.nr_order <= 1;
