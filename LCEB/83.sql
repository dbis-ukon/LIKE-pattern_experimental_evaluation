SELECT a.title, ch.name AS character_name, k.keyword, lt.link
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN char_name ch ON ci.person_role_id = ch.id
LEFT JOIN movie_keyword mk ON a.movie_id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
LEFT JOIN movie_link ml ON a.movie_id = ml.movie_id
LEFT JOIN link_type lt ON ml.link_type_id = lt.id
WHERE a.title LIKE 'T% F%T_co%'
  AND ch.name LIKE '%e_Bil_'
  AND k.keyword LIKE 'f%tc%'
  AND lt.link LIKE '%Sequel%'
  AND a.season_nr = 2
  AND a.episode_nr <= 11
  AND a.production_year >= 2001;
