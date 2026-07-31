SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       akat.title, akat.episode_nr
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN aka_title akat ON ci.movie_id = akat.movie_id
WHERE cn.name LIKE 'A%ain_an_e in _ym'
  AND cn.name_pcode_nf = 'K4352'
  AND (cn.md5sum LIKE 'd4e5f6%' OR cn.imdb_id > 2000)
  AND akat.episode_nr BETWEEN 8 AND 9;
