SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE 'Grey'
  AND t.season_nr BETWEEN 1 AND 2
  AND t.episode_nr IS NOT NULL
  AND t.imdb_index LIKE 'tt%';
