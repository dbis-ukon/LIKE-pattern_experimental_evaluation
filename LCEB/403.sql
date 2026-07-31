SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE 'Th%A%V_s_o_'
  AND akat.production_year BETWEEN 1912 AND 1953
  AND akat.kind_id = 1;
