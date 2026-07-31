SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE '_l_mpse%o_ % %fe' OR t.title LIKE 'Vivre % vie: Fil_ en douze t_ble_ux')
  AND t.production_year BETWEEN 1988 AND 1996
  AND t.kind_id = 7
  AND t.md5sum IS NOT NULL;
