SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE 'Pája_os en la_ca_e_a'
  AND t.episode_nr BETWEEN 1 AND 3
  AND t.imdb_index LIKE 'tt%'
  AND t.md5sum IS NOT NULL;
