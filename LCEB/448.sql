SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE 'A_te O''%' OR cn.name LIKE '_a_adian')
  AND cn.md5sum LIKE 'g7h8i9%'
  AND cn.name_pcode_nf = 'P6365'
  AND ci.nr_order <= 2;
