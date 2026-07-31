SELECT akat.movie_id, cn_villain.name, k.keyword, mi.id AS movie_info_index
FROM aka_title akat
JOIN cast_info ci_villain ON akat.movie_id = ci_villain.movie_id
JOIN char_name cn_villain ON ci_villain.person_id = cn_villain.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_info_idx mi ON akat.movie_id = mi.movie_id
WHERE cn_villain.name LIKE '_hi_i% %j_t_'
  AND k.keyword LIKE 'dekalb-illinois'
  AND mi.id IS NOT NULL
ORDER BY mi.id DESC;
