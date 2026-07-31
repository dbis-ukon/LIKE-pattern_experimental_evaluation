SELECT c.id, c.name, c.country_code, c.md5sum,
       mc.movie_id, akat.title
FROM company_name c
JOIN movie_companies mc ON c.id = mc.company_id
JOIN aka_title akat ON mc.movie_id = akat.movie_id
WHERE c.name LIKE 'C%F_l%'
  AND akat.production_year BETWEEN 1943 AND 1999
  AND mc.company_type_id = 2;
