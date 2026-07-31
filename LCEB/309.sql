SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE 'Fannie Perkins' OR cn.name LIKE '%is Jac_b_' OR cn.name LIKE 'Punt_r _')
  AND cn.name_pcode_nf = 'A5324'
  AND cn.md5sum LIKE 'j10k11%';
