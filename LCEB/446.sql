SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE 'Carol_ne Vale Ransom' OR cn.name LIKE 'Moussette')
  AND cn.md5sum LIKE 'f6g7h8%'
  AND cn.name_pcode_nf = 'F635'
  AND akat.kind_id IN (1, 3, 4);
