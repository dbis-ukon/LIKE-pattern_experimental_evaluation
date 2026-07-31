SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE '_ow _h_ %lar _yste_ was_Ma_e'
  AND t.episode_nr > 5
  AND t.md5sum IS NOT NULL
  AND t.imdb_index LIKE 'tt%';
