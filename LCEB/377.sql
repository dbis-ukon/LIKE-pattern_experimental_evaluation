SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE '_.V%il%rod%t_ons'
  AND c.imdb_id BETWEEN 500 AND 5000
  AND c.name_pcode_sf LIKE 'S%';
