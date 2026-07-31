SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE '% % %e%R%' OR akat.title LIKE 'Bull_ig_t _n France' OR akat.title LIKE 'Modesty')
  AND akat.episode_nr BETWEEN 3 AND 6
  AND akat.md5sum IS NOT NULL;
