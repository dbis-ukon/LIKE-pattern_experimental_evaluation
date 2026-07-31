SELECT akat.id, akat.title, akat.production_year, akat.kind_id,
       mc.company_id, c.name AS company_name
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE 'The Sugar D_ll'
  AND c.country_code = '[lk]'
  AND akat.production_year >= 1972;
