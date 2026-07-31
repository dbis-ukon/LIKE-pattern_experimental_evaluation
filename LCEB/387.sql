SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE c.name LIKE 'K_nokom_a_iya C_eroma_Film'
  AND c.name_pcode_nf LIKE 'P%'
  AND c.imdb_id BETWEEN 1000 AND 5000;
