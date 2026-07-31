SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE 'U_a _ener%storia' OR t.title LIKE '(#3_3)')
  AND t.production_year BETWEEN 1971 AND 1981
  AND t.md5sum LIKE 'h8i9j0%'
  AND t.kind_id = 1;
