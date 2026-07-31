SELECT a.title, ch.name AS char_name, k.keyword, mi.info
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name ch ON ci.person_id = ch.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_info_idx mi ON a.movie_id = mi.movie_id
WHERE a.title LIKE '_martoles gynaikes stin T_ouba'
  AND ch.name LIKE '%F A_ent W%ton'
  AND k.keyword LIKE 'oi_y-h%r'
  AND mi.info IS NOT NULL
  AND a.production_year BETWEEN 1957 AND 1964
  AND ci.nr_order <= 9
  AND a.season_nr IS NOT NULL;
