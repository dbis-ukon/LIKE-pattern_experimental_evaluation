SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE 'Zentro_y_F_lms' OR c.name LIKE 'Gon_al%T. %rv%t_s')
  AND c.country_code = '[it]'
  AND c.md5sum LIKE 'd4e5%';
