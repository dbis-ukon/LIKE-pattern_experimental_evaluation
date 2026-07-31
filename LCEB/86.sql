SELECT a.title, ch.name AS character_name, co.name AS company_name, n.name AS actor_name, k.keyword
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN char_name ch ON ci.person_role_id = ch.id
LEFT JOIN movie_companies mc ON a.movie_id = mc.movie_id
LEFT JOIN company_name co ON mc.company_id = co.id
LEFT JOIN name n ON ci.person_id = n.id
LEFT JOIN movie_keyword mk ON a.movie_id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE '%W%o_'
  AND ch.name LIKE '_on-B_on_e'
  AND co.name LIKE '%e%a_f_lms'
  AND n.name LIKE '_ang'
  AND k.keyword LIKE 'penis-pump'
  AND a.season_nr = 1
  AND a.episode_nr <= 18;
