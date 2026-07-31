SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE 'K%t%'
  AND akat.production_year BETWEEN 1972 AND 2002
  AND akat.season_nr IS NOT NULL;
