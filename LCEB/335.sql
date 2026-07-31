SELECT id, title, imdb_index, kind_id, production_year, imdb_id, phonetic_code, episode_of_id, season_nr, episode_nr, series_years, md5sum
FROM title t
WHERE (t.title LIKE 'Norman Wi_do_' OR t.title LIKE '(#1.638_' OR t.title LIKE '% M_ntal H%p%')
  AND t.production_year >= 1988
  AND t.md5sum LIKE 'a1b2c3%'
  AND t.kind_id IN (7, 1, 3);
