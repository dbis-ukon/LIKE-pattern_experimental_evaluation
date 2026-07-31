SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE 'C%n%' OR cn.name LIKE 'M%l%J%c_')
  AND cn.md5sum LIKE 'f6g7h8%'
  AND cn.name_pcode_nf = 'M2525';
