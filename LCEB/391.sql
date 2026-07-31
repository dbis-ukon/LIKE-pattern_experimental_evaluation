SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE 'Stu_i_ T%g_ad'
  AND c.name_pcode_nf LIKE 'U%'
  AND c.imdb_id BETWEEN 100 AND 10000;
