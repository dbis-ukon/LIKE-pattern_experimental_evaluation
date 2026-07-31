SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE 'New_Ca%l%i%ures' OR c.name LIKE '%r%en_')
  AND c.country_code = '[mx]'
  AND c.md5sum IS NOT NULL;
