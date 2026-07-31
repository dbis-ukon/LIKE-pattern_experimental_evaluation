SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.title
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE '%r%en' OR cn.name LIKE 'C%i_ _mp%ss%ni_t')
  AND cn.md5sum IS NOT NULL
  AND cn.surname_pcode = 'C613'
  AND akat.kind_id IN (1, 2, 4);
