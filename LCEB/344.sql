SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE t.title LIKE 'B%n_of K_ngs and An_el_'
  AND t.episode_of_id IS NOT NULL
  AND t.imdb_id > 2000
  AND t.series_years LIKE '%2000-2010%';
