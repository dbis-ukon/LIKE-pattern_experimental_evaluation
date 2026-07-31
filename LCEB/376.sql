SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE '%s%ng% F%' OR c.name LIKE '_i_f_r%Fil%' OR c.name LIKE '_r_rn_ Films')
  AND c.country_code = '[us]'
  AND c.md5sum LIKE 'a1b2%';
