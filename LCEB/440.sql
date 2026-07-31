SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       ci.role_id, akat.production_year
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE (cn.name LIKE '_icnic_Woman_2' OR cn.name LIKE 'Park Range_ Amy')
  AND cn.imdb_id < 10000
  AND cn.name_pcode_nf = 'T3524'
  AND cn.surname_pcode = 'C613'
  AND akat.production_year BETWEEN 1985 AND 1988;
