SELECT t.id, n.name_pcode_nf
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (k.keyword LIKE 'ea_-biting' OR k.keyword LIKE '_ef_r_n_e_to_rica_do-mo_talban')
  AND t.title LIKE '%1_3_)'
  AND n.name LIKE '_ó%z_M_ño%u%a%'
  AND akat.title LIKE 'Cocaine-Parad_se'
  AND co.name LIKE 'Cin_Té Filmproductie BV'
  AND cn.name LIKE '%i%m%t%'
  AND n.name_pcode_nf IS NOT NULL
  AND t.production_year > 2005
  AND ci.nr_order <= 4
  AND mc.company_type_id = 1;
