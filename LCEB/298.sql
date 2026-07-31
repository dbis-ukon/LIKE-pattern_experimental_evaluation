SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE '_._._ S_e%r%#_' OR cn.name LIKE 'Mélanie_T_usi_na_t')
  AND cn.md5sum IS NOT NULL
  AND cn.surname_pcode = 'W1';
