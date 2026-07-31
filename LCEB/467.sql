SELECT n.id, n.name, n.name_pcode_nf, n.gender,
       akat.title, akat.production_year
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE n.name LIKE '%re_ L%e'
  AND (n.name_pcode_nf = 'D5425' OR n.imdb_id > 2000)
  AND n.gender = 'm'
  AND akat.production_year >= 1974;
