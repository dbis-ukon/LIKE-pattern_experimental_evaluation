SELECT a.title, ch.name AS character_name, n.name AS actor_name, lt.link, co.name AS company_name
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN char_name ch ON ci.person_role_id = ch.id
LEFT JOIN name n ON ci.person_id = n.id
LEFT JOIN movie_link ml ON a.movie_id = ml.movie_id
LEFT JOIN link_type lt ON ml.link_type_id = lt.id
LEFT JOIN movie_companies mc ON a.movie_id = mc.movie_id
LEFT JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'U_t_r_Nu_l'
  AND ch.name LIKE '_tudent%u_se_L_n_h'
  AND n.name LIKE '_o%s%a%e%'
  AND lt.link LIKE '%Sequel%'
  AND co.name LIKE 'TORO-_ilm G_bH B_rlin'
  AND a.season_nr = 2
  AND a.episode_nr <= 3;
