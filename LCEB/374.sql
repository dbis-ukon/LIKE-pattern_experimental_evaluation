SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE 'S%ptom%c Fi%r_duc%o_'
  AND c.imdb_id > 1000
  AND c.name_pcode_nf LIKE 'E%';
