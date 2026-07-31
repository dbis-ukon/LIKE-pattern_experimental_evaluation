SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE '% %r_ o_i_la' OR t.title LIKE '(#%963)')
  AND t.md5sum LIKE 'b2c3d4%'
  AND t.kind_id IN (2, 1, 3, 7, 4)
  AND t.season_nr IS NOT NULL;
