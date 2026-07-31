SELECT akat.id, akat.title, akat.production_year, akat.kind_id,
       mc.company_id, c.name AS company_name,
       mk.keyword_id, k.keyword,
       ci.person_id
FROM aka_title akat
JOIN movie_companies mc   ON akat.movie_id = mc.movie_id
JOIN company_name c       ON mc.company_id = c.id
JOIN movie_keyword mk     ON akat.movie_id = mk.movie_id
JOIN keyword k            ON mk.keyword_id = k.id
LEFT JOIN cast_info ci    ON akat.movie_id = ci.movie_id
WHERE akat.title LIKE 'The Realit_ _f Ja_ Vrij%'
  AND akat.title LIKE '%a%R%a_a%Id_on:_A_C%'
  AND c.name LIKE 'Mi_de_ Music Records'
  AND c.country_code = '[us]'
  AND mc.company_type_id IN (1, 2)
  AND k.keyword LIKE '%c_-to-m%'
  AND akat.production_year BETWEEN 1966 AND 2003
  AND akat.kind_id IN (2, 1)
  AND ci.role_id IS NOT NULL;
