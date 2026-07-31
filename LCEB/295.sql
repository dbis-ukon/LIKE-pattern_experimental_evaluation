SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE '_he Texican'
  AND (cn.name_pcode_nf = 'D256' OR cn.surname_pcode LIKE 'C%')
  AND cn.md5sum IS NOT NULL;
