SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE '%h_e%n %s'
  AND c.imdb_id > 1000
  AND c.name_pcode_sf LIKE 'S%';
