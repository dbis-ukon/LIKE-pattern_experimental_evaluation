SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE 'T.V. Salesman'
  AND cn.md5sum LIKE 'c3d4e5f6%'
  AND (cn.imdb_id BETWEEN 1000 AND 5000 OR cn.name_pcode_nf = 'I5212')
  AND akat.production_year BETWEEN 1939 AND 1999;
