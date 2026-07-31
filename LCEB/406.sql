SELECT id, movie_id, title, imdb_index, kind_id, production_year, phonetic_code, episode_of_id, season_nr, episode_nr, note, md5sum
FROM aka_title akat
WHERE (akat.title LIKE '_S_: T% _onc_rt' OR akat.title LIKE 'Ra_n')
  AND akat.episode_of_id IS NOT NULL
  AND akat.phonetic_code LIKE 'C%';
