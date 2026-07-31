SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE '_ab_i%le Bourg_n_uf'
  AND cn.md5sum LIKE 'c3d4e5f6%'
  AND (cn.imdb_id BETWEEN 1000 AND 5000 OR cn.name_pcode_nf = 'K6252');
