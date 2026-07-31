SELECT n.id, n.name, n.name_pcode_nf, n.md5sum,
       akat.title, akat.production_year
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE n.name LIKE '_hevreul'
  AND (n.imdb_index LIKE 'nm%' OR n.gender = 'f')
  AND akat.production_year >= 1975;
