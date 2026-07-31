SELECT t.id, n.imdb_index
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (k.keyword LIKE '_earchi_g' OR k.keyword LIKE '%ua_-h_ras_m_n_-_r%cor_u%-_ol%o%n')
  AND (t.title LIKE '(_1%1)' OR t.title LIKE '_gr%u%u_e _n H_n_a_y')
  AND n.name LIKE '_d%C%'
  AND akat.title LIKE '_x_l% %'
  AND co.name LIKE '_oru%C_ne_a_'
  AND cn.name LIKE 'Gas-House Gorillas Left Fielder'
  AND n.imdb_index IS NOT NULL
  AND ci.nr_order <= 3
  AND t.kind_id = 7
  AND mc.company_id > 19;
