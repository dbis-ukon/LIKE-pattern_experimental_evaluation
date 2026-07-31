SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE 'Th_atre Pic_ures'
  AND c.name_pcode_nf LIKE 'W%'
  AND c.imdb_id > 2000;
