SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title, akat.kind_id
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE 'D_ache_Koks'
  AND (cn.imdb_id BETWEEN 500 AND 5000 OR cn.imdb_index LIKE 'nm%')
  AND cn.name_pcode_nf = 'M5262'
  AND cn.md5sum LIKE 'a1b2c3d4e5f6%'
  AND akat.kind_id IN (2, 1, 4, 3);
