SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE '%e%t'
  AND cn.surname_pcode = 'F2'
  AND cn.md5sum LIKE 'i9j0k1%'
  AND cn.imdb_id > 3000;
