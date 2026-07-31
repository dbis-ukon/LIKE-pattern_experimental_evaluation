SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       kt.kind AS kind_name
FROM aka_title akat
JOIN kind_type kt ON akat.kind_id = kt.id
WHERE akat.title LIKE '%l% B%'
  AND akat.production_year >= 2004
  AND akat.kind_id = 1
  AND kt.kind LIKE 'War%';
