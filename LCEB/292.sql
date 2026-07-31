SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE 'Bla%p' OR cn.name LIKE '% _t%ol_ -_C_ildh%d_Y%rs')
  AND cn.imdb_id > 1000
  AND cn.name_pcode_nf = 'W23'
  AND cn.surname_pcode = 'S525'
  AND cn.md5sum IS NOT NULL;
