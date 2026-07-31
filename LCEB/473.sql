SELECT n.id, n.name, n.name_pcode_cf, n.md5sum,
       akat.title, akat.kind_id
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE n.name LIKE '_an_e%'
  AND (n.gender = 'm' OR n.name_pcode_nf = 'T52')
  AND akat.kind_id IN (2, 3, 1, 4);
