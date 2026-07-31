SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE 'Le secret de la chambre claire'
  AND akat.production_year BETWEEN 1938 AND 2009
  AND akat.phonetic_code LIKE 'Q%';
