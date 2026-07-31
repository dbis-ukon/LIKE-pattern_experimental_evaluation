SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE 'On Line' OR akat.title LIKE '_he_F%s_')
  AND akat.episode_nr >= 1
  AND akat.phonetic_code LIKE 'F%';
