SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE '%e_Trea_u_e' OR akat.title LIKE '%e_ %e%l')
  AND akat.episode_nr >= 1
  AND akat.kind_id IN (2, 1);
