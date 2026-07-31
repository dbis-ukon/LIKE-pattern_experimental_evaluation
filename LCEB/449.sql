SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE '%us_Barr_e'
  AND cn.surname_pcode = 'C624'
  AND cn.md5sum LIKE 'h8i9j0%'
  AND akat.kind_id = 3;
