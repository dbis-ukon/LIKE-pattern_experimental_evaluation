SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE 'Ze%ö%n_'
  AND akat.production_year < 1972
  AND akat.season_nr IS NOT NULL;
