SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE '_lm_ Drak_' OR cn.name LIKE 'S%nter_ng _nmate')
  AND cn.name_pcode_nf = 'C1356'
  AND cn.md5sum IS NOT NULL;
