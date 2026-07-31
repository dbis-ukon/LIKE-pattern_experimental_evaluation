SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE '_a%h%s%e% %' OR cn.name LIKE 'Tou% _uy in_Cell')
  AND cn.name_pcode_nf = 'C4325'
  AND cn.surname_pcode = 'D236'
  AND ci.nr_order <= 3;
