SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE cn.name LIKE 'Himself - Ven_zue_an _xile'
  AND cn.surname_pcode = 'K5'
  AND cn.md5sum LIKE 'h8i9j0%';
