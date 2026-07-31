SELECT n.id, n.name, n.imdb_id, n.name_pcode_cf,
       akat.title
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE n.name LIKE '_u_z_ Jose'
  AND (n.gender = 'f' OR n.imdb_id < 10000)
  AND akat.production_year BETWEEN 1934 AND 1943;
