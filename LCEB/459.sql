SELECT n.id, n.name, n.gender, n.imdb_index,
       akat.title, akat.kind_id
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE (n.name LIKE 'G_dlow' OR n.name LIKE 'Hodges')
  AND n.surname_pcode = 'C626'
  AND akat.kind_id IN (3, 2, 1);
