SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE 'N_efu Productions' OR c.name LIKE '%n_l%l%')
  AND c.country_code = '[fr]'
  AND c.md5sum LIKE 'b2c3%';
