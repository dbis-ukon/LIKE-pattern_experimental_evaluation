SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE '_i_Fai''_ Sis_er'
  AND cn.surname_pcode = 'C6515'
  AND cn.md5sum IS NOT NULL
  AND cn.imdb_id < 20000;
