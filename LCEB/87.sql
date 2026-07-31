SELECT a.title, ch.name AS character_name, co.name AS company_name, k.keyword, lt.link, n.name AS actor_name
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN char_name ch ON ci.person_role_id = ch.id
LEFT JOIN movie_companies mc ON a.movie_id = mc.movie_id
LEFT JOIN company_name co ON mc.company_id = co.id
LEFT JOIN movie_keyword mk ON a.movie_id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
LEFT JOIN movie_link ml ON a.movie_id = ml.movie_id
LEFT JOIN link_type lt ON ml.link_type_id = lt.id
LEFT JOIN name n ON ci.person_id = n.id
WHERE a.title LIKE 'S_a_d% % _ol%o%'
  AND ch.name LIKE 'F%d%wai%'
  AND co.name LIKE 'Napenda Prod_c_ions'
  AND k.keyword LIKE '%to%gard_n'
  AND lt.link LIKE '%Sequel%'
  AND n.gender = 'm'
  AND a.season_nr = 13
  AND a.episode_nr <= 1;
