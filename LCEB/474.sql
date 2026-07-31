SELECT n.id, n.name, n.gender, n.imdb_index,
       akat.title, akat.production_year
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE (n.name LIKE 'Masugata' OR n.name LIKE 'Pi%r_ A%on')
  AND n.name LIKE '%k%a_ %l_'
  AND n.surname_pcode LIKE 'H%'
  AND akat.production_year BETWEEN 1974 AND 1982;
