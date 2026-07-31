SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE '%ss %s%' OR cn.name LIKE 'Lady%tri_ia Fa_rfax')
  AND cn.imdb_id > 1000
  AND cn.name_pcode_nf = 'C4542'
  AND cn.surname_pcode = 'W524'
  AND cn.md5sum IS NOT NULL
  AND ci.nr_order <= 57
  AND akat.production_year BETWEEN 1989 AND 2003;
