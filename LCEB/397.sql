SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE '_os% _u%'
  AND akat.production_year >= 1993
  AND akat.kind_id IN (3, 6, 4, 1, 2);
