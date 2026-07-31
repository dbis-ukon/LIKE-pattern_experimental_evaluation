SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE 'G_r_ge_ilm A_' OR c.name LIKE 'Göteb%g_ H%')
  AND c.country_code = '[us]'
  AND c.md5sum IS NOT NULL;
