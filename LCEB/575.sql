SELECT n.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'c_ataq_a'
  AND t.title LIKE 'T_e_L%Ep_s_d_'
  AND n.name LIKE 'Farso% Sarah'
  AND akat.title LIKE '%r%nd%'
  AND co.name LIKE 'Renz_ne Music'
  AND cn.name LIKE '% _l%n_:%m%e'
  AND t.production_year > 1996
  AND ci.nr_order <= 10
  AND mc.company_id > 4226
  AND t.kind_id = 7;
