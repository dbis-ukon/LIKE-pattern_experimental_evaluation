SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title, akat.kind_id
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE '_t%r%'
  AND (cn.name_pcode_nf = 'B6145' OR cn.surname_pcode LIKE 'C%')
  AND cn.md5sum IS NOT NULL
  AND akat.kind_id = 1;
