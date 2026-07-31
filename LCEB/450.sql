SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE 'Dum_n_el' OR cn.name LIKE '%cr%es_Ho_e_ de _ello')
  AND cn.name_pcode_nf = 'P2121'
  AND cn.md5sum IS NOT NULL
  AND ci.nr_order <= 1;
