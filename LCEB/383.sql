SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE 'Ext_n_io%765'
  AND c.imdb_id > 500
  AND c.name_pcode_nf LIKE 'L%';
