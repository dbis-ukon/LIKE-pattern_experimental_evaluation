SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE '_a_ink_'
  AND t.episode_nr BETWEEN 3 AND 9
  AND t.imdb_index LIKE 'tt%'
  AND t.md5sum IS NOT NULL;
