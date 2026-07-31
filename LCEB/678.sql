SELECT t.title, co.name, co.country_code, t.production_year
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE mc.note IS NULL
  AND mc.company_type_id = 1
  AND co.country_code = '[us]'
  AND t.production_year BETWEEN 1985 AND 2007
  AND co.name LIKE 'S_an_Aro_son'
  AND t.title LIKE 'A Dog in a Co_ner''s _en'
ORDER BY co.name;
