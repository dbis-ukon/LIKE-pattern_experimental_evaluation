SELECT t.id, t.imdb_index
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE '%ston%lobe-cr_t_cs-cho_ce-w_nn%'
  AND (t.title LIKE 'Ki_me%t_a%m' OR t.title LIKE '_he_A_g% %d_o Game N_r_')
  AND n.name LIKE 'Hee_y%H%y'
  AND akat.title LIKE '%e_uv% % valandos'
  AND co.name LIKE 'Me_td% G_y Pr_ducti_ns'
  AND cn.name LIKE 'Tom Whitman - age 47'
  AND t.imdb_index IS NOT NULL
  AND t.production_year >= 2000
  AND ci.role_id = 10
  AND mc.company_type_id = 1;
