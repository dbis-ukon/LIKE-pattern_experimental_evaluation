SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE 'Fa_ f_o%o_e' OR t.title LIKE 'T_e Passe%e_ _n Se_t %A')
  AND t.production_year BETWEEN 1988 AND 2011
  AND t.kind_id = 7
  AND t.md5sum IS NOT NULL;
