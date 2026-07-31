SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE '%ek%m%' OR akat.title LIKE 'R_n%')
  AND akat.season_nr BETWEEN 1 AND 1
  AND akat.md5sum IS NOT NULL;
