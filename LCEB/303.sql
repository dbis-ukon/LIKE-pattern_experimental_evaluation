SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE '%u%a_Rö_l_r'
  AND cn.surname_pcode = 'V5'
  AND cn.imdb_id BETWEEN 500 AND 6000;
