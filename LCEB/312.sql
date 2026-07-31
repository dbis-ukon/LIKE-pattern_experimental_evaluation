SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE 'Androcles'
  AND cn.surname_pcode = 'G4365'
  AND cn.md5sum LIKE 'l12m13%'
  AND cn.imdb_id BETWEEN 1000 AND 10000;
