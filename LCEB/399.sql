SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE akat.title LIKE '%on% D% Pr_f_'
  AND akat.production_year BETWEEN 1976 AND 2013
  AND akat.kind_id = 1;
