SELECT a.title, ch.name AS character_name, co.name AS company_name, n.name AS actor_name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name ch ON ci.person_role_id = ch.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'L''_duca_i_ne fi_i_a _el_e_fanciul_e'
  AND ch.name LIKE '%f%n%r a_d_M_s_c%'
  AND co.name LIKE '%m%F%'
  AND n.name LIKE 'Vangelista'
  AND a.season_nr = 1
  AND a.episode_nr <= 3
  AND ci.nr_order <= 5;
