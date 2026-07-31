SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE 'Si_kerw%' AND cn.name LIKE '_ucille S_e_ar_')
  AND cn.name_pcode_nf = 'Y5213'
  AND cn.md5sum LIKE 'k11l12%'
  AND ci.nr_order <= 4;
