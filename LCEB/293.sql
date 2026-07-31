SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE 'H%r%l%t%t_m_1%'
  AND (cn.imdb_id BETWEEN 500 AND 5000 OR cn.imdb_index LIKE 'nm%')
  AND cn.name_pcode_nf = 'T52'
  AND cn.md5sum LIKE 'a1b2c3d4e5f6%';
