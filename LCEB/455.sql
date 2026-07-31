SELECT cn.id, cn.name, cn.imdb_index, cn.imdb_id, cn.name_pcode_nf, cn.surname_pcode, cn.md5sum,
       mc.company_type_id, c.name AS company_name
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN movie_companies mc ON ci.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE cn.name LIKE 'Mil% %'
  AND cn.surname_pcode = 'F2'
  AND cn.md5sum LIKE 'l12m13%'
  AND cn.imdb_id BETWEEN 1000 AND 10000
  AND c.country_code = '[gb]';
