SELECT t.id, t.title, n.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'reference-to%ri_ia-ni%n'
  AND t.title LIKE 'Bu_ay%y_il_'
  AND n.name LIKE 'Nguyen'
  AND akat.title LIKE 'L_ v%tap_gine'
  AND co.name LIKE 'P%u_s_c_e_ P_oduc_ions'
  AND cn.name LIKE 'Fe%ra_i_n Me_i_'
  AND t.production_year > 1973
  AND ci.nr_order <= 14
  AND mc.company_type_id >= 2
  AND t.kind_id = 1;
