SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE '%a%v%n%'
  AND t.episode_nr IS NOT NULL
  AND t.series_years LIKE '%2014-2019%'
  AND t.md5sum IS NOT NULL;
