SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE 'Just Vision Fil_s'
  AND c.name_pcode_sf LIKE 'P%'
  AND c.imdb_id BETWEEN 1000 AND 3000;
