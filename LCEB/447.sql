SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE 'F_rgott% Man'
  AND cn.surname_pcode = 'D3'
  AND cn.imdb_id BETWEEN 500 AND 6000
  AND akat.production_year >= 2003;
