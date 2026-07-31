SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       at2.title AS episode_of_title
FROM aka_title akat
JOIN aka_title at2 ON akat.episode_of_id = at2.id
WHERE akat.title LIKE 'Type_k_ta'
  AND akat.production_year BETWEEN 1935 AND 1978
  AND akat.phonetic_code LIKE 'Q%'
  AND at2.production_year >= 1917;
