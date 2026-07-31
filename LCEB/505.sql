SELECT
    akat.movie_id,
    MAX(akat.production_year) AS latest_year,
    MIN(c.country_code) AS country,
    COUNT(*) AS company_rows
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE akat.title LIKE 'I%t%o%ell_ %'
  AND c.name LIKE 'SG_Vide_'
  AND ct.kind LIKE '%production%'
  AND c.country_code = '[us]'
  AND mc.company_type_id IN (2, 1)
GROUP BY akat.movie_id
HAVING COUNT(*) > 1;
