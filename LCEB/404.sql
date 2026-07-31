SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE '_a vend_tta dei morti viventi' OR akat.title LIKE 'Evangelion 2.22: Yo_ _an_(Not) Advan_e')
  AND akat.season_nr IS NOT NULL
  AND akat.md5sum IS NOT NULL;
