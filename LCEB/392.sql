SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE '%g%v%' OR c.name LIKE 'V%e%n_')
  AND c.country_code = '[lv]'
  AND c.md5sum IS NOT NULL;
