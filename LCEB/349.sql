SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE 'The_''%Women' OR t.title LIKE 'Faul_')
  AND t.production_year BETWEEN 1992 AND 2013
  AND t.kind_id IN (6, 7, 2, 1, 3)
  AND t.md5sum LIKE 'g7h8i9%';
