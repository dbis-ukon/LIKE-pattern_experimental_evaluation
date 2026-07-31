SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE 'B_ro%v% Cha_i%'
  AND cn.name_pcode_nf = 'H426'
  AND (cn.md5sum LIKE 'd4e5f6%' OR cn.imdb_id > 2000);
