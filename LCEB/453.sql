SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title, akat.kind_id
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE 'S%ve _o%y%gdale%'
  AND cn.surname_pcode = 'L132'
  AND cn.md5sum IS NOT NULL
  AND cn.imdb_id < 20000
  AND akat.kind_id = 1;
