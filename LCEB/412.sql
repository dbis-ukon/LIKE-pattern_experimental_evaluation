SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE 'P_p-_p B_ad_' OR akat.title LIKE '%s%g%')
  AND akat.episode_of_id IS NOT NULL
  AND akat.kind_id IN (2, 1, 4);
