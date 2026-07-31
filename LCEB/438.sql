SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE '_a_ Kolb' OR cn.name LIKE '_eat_er _r_g%' OR cn.name LIKE 'Herself Sens_tive')
  AND cn.surname_pcode = 'B236'
  AND cn.md5sum LIKE 'b2c3d4e5f6%'
  AND cn.imdb_id > 2000
  AND ci.nr_order <= 15
  AND akat.production_year >= 2007;
