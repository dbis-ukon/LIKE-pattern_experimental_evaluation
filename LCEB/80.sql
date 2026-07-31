SELECT a.title, co.name AS company_name, mi.info, ch.name AS char_name
FROM aka_title a
LEFT JOIN movie_companies mc ON a.movie_id = mc.movie_id
LEFT JOIN company_name co ON mc.company_id = co.id
LEFT JOIN movie_info_idx mi ON a.movie_id = mi.movie_id
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN char_name ch ON ci.person_role_id = ch.id
WHERE a.title LIKE 'I _igli di _anchez'
  AND co.name LIKE 'Gol%n_Goat S_u_io_'
  AND mi.info IS NOT NULL
  AND ch.name LIKE '_u%d of%onch%ar'
  AND a.production_year >= 1965;
