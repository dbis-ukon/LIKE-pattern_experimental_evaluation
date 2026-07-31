SELECT n.id, n.name, n.name_pcode_nf, n.md5sum,
       akat.title, akat.kind_id
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE n.name LIKE '_rowe% Eli_abeth'
  AND (n.name_pcode_cf = 'C6545' OR n.gender = 'f')
  AND akat.production_year BETWEEN 1970 AND 1981;
