SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE 'Fancy Lala' OR cn.name LIKE 'Je_im%Wel%t%-%e_n' OR cn.name LIKE 'Phili_ Cooke')
  AND cn.name_pcode_nf = 'H5241'
  AND cn.md5sum LIKE 'j10k11%'
  AND ci.nr_order <= 2
  AND akat.kind_id IN (4, 2, 1, 3);
