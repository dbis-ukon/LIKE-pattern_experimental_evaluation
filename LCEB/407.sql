SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE 'Rap%ento_di_un _residente'
  AND akat.production_year BETWEEN 1925 AND 2003
  AND akat.md5sum IS NOT NULL;
