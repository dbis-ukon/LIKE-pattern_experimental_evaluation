SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE '(1_9_-01_16_'
  AND t.episode_of_id IS NOT NULL
  AND t.md5sum IS NOT NULL
  AND t.production_year >= 1911;
