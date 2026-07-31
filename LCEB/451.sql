SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title, akat.production_year
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE 'T_ak'
  AND cn.surname_pcode = 'K52'
  AND cn.md5sum LIKE 'i9j0k1%'
  AND cn.imdb_id > 3000
  AND akat.production_year BETWEEN 1964 AND 1981;
