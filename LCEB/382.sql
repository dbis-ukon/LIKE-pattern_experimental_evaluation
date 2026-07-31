SELECT id, name, country_code, imdb_id, name_pcode_nf, name_pcode_sf, md5sum
FROM company_name c
WHERE (c.name LIKE '_a%l_ Ho_izo%' OR c.name LIKE '%o_ %Produ_t_o%')
  AND c.country_code = '[gb]'
  AND c.md5sum IS NOT NULL;
