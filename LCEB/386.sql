SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE '%ul%Pr%cti%s' OR c.name LIKE 'Triple _ct%n Theatr_')
  AND c.country_code = '[us]'
  AND c.md5sum IS NOT NULL;
