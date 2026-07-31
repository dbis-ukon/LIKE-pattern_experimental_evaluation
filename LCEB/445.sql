SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title, akat.production_year
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE '_a_i_n_e% _e_ke%t%'
  AND cn.md5sum LIKE 'e5f6g7%'
  AND cn.imdb_id > 1000
  AND cn.surname_pcode = 'D653'
  AND akat.production_year BETWEEN 1938 AND 2013;
