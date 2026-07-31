SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE '_i_a_Suska' OR cn.name LIKE '_i%t_n')
  AND cn.imdb_id < 10000
  AND cn.name_pcode_nf = 'A4253'
  AND cn.surname_pcode = 'T252';
