SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE 'S_a%a%on%' OR cn.name LIKE '%t%o_' OR cn.name LIKE 'L_dy_Li_d_')
  AND cn.surname_pcode = 'S5'
  AND cn.md5sum LIKE 'b2c3d4e5f6%'
  AND cn.imdb_id > 2000;
