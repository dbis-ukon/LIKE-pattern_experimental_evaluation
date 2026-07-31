SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE '_utop_y'
  AND t.series_years LIKE '%2010-2020%'
  AND t.imdb_id BETWEEN 1000 AND 10000
  AND t.episode_nr > 13;
