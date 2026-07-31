SELECT n.id, n.name, n.name_pcode_cf, n.surname_pcode,
       akat.production_year
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE n.name LIKE 'B_ldido'
  AND (n.name LIKE '_an%n' OR n.gender = 'f')
  AND akat.production_year BETWEEN 1965 AND 2013;
