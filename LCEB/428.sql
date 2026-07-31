SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       ci.nr_order, cn.name AS main_character
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE (akat.title LIKE '_y_t%e % %s %o%i_r_ d%s%A%' OR akat.title LIKE 'L%go_t%e_m%s%re')
  AND akat.season_nr IS NOT NULL
  AND akat.md5sum IS NOT NULL
  AND ci.nr_order <= 17
  AND cn.name LIKE 'T_om% Li%ard';
