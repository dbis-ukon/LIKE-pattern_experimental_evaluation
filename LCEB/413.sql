SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE 'De_er%ra_os'
  AND akat.production_year >= 1933
  AND akat.md5sum IS NOT NULL;
