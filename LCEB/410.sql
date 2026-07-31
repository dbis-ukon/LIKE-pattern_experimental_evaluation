SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE 'H% %n%' OR akat.title LIKE '%lla _amera di M_bel')
  AND akat.episode_nr BETWEEN 20 AND 197
  AND akat.md5sum IS NOT NULL;
