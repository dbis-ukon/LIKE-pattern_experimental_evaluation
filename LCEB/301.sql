SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE '%rn_ Wit%g'
  AND cn.md5sum LIKE 'e5f6g7%'
  AND cn.imdb_id > 1000
  AND cn.surname_pcode = 'G3';
