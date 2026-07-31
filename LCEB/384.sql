SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE 'Kristalli-Filmi Oy' OR c.name LIKE '%l_P_o%i%')
  AND c.country_code = '[us]'
  AND c.md5sum LIKE 'c3d4%';
