SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE 'Reibu_u'
  AND t.series_years LIKE '%2015-2020%'
  AND t.episode_nr > 17
  AND t.imdb_id > 5000;
