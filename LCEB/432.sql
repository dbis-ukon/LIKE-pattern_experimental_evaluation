SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       kt.kind AS kind_name
FROM aka_title akat
JOIN kind_type kt ON akat.kind_id = kt.id
WHERE akat.title LIKE 'Sm%i_g _ld C%mneys'
  AND akat.production_year BETWEEN 1964 AND 2004
  AND akat.season_nr IS NOT NULL
  AND kt.kind LIKE 'Adventure%';
