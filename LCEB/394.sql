SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE 'We_ding_Bell%for_H%y' OR akat.title LIKE 'Les tem_s héroïques')
  AND akat.production_year BETWEEN 1957 AND 1973
  AND akat.kind_id = 1;
