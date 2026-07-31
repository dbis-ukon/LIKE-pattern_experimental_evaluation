SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE 'Di%ta%Med_a%id Fi%Ca_p' OR c.name LIKE 'T%g_W%Grou% %pi%ls')
  AND c.country_code = '[us]'
  AND c.md5sum IS NOT NULL;
