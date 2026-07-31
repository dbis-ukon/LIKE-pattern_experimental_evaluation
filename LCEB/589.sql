SELECT t.id, t.episode_nr
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (k.keyword LIKE '_it-o_-t_e%e_d-%h%-_t%k' OR k.keyword LIKE 'h_t-wi_h-a%owl')
  AND t.title LIKE 'Cellulo_d Drea_s'
  AND n.name LIKE 'Salce_o'
  AND akat.title LIKE 'C_l%t% R%k'
  AND co.name LIKE '%i% _r%c_io_s'
  AND cn.name LIKE '_''empl_yée % l_a_ence'
  AND t.episode_nr >= 37
  AND t.season_nr = 1
  AND n.gender = 'm'
  AND ci.role_id = 2;
