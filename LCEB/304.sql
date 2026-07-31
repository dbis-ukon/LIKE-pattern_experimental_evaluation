SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE '%id_n %y' OR cn.name LIKE 'P%o%Le_n%d_s')
  AND cn.md5sum LIKE 'g7h8i9%'
  AND cn.name_pcode_nf = 'M465';
