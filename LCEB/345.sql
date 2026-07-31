SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE 'B% %e%ve_t' OR t.title LIKE '_he W_ite_Flowers o_ Co%a_s_')
  AND t.production_year BETWEEN 1964 AND 1985
  AND t.md5sum LIKE 'e5f6g7%'
  AND t.kind_id = 7;
