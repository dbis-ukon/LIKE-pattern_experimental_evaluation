SELECT id, name, imdb_index, imdb_id, name_pcode_nf, surname_pcode, md5sum
FROM char_name cn
WHERE (cn.name LIKE 'Gi_l%n Ston_' OR cn.name LIKE 'Ga%')
  AND cn.name_pcode_nf = 'K3264'
  AND cn.surname_pcode = 'F435';
