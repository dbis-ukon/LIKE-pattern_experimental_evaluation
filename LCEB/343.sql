SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE '_e_e% %' OR t.title LIKE '_a% Night')
  AND t.production_year >= 2011
  AND t.kind_id = 7
  AND t.md5sum LIKE 'd4e5f6%';
