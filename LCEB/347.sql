SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE 'Jungle Pursuit' OR t.title LIKE 'Personality Plus')
  AND t.production_year BETWEEN 2007 AND 2013
  AND t.kind_id = 7
  AND t.md5sum LIKE 'f6g7h8%';
