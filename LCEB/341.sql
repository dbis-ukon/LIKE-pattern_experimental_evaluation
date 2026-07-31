SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE 'Ke_t' OR t.title LIKE 'Los j_guet_s')
  AND t.production_year BETWEEN 2008 AND 2012
  AND t.md5sum LIKE 'c3d4e5%'
  AND t.kind_id = 7;
