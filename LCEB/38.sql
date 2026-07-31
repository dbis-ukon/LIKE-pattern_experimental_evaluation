SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       COUNT(DISTINCT k1.keyword) AS primary_keywords,
       COUNT(DISTINCT k2.keyword) AS secondary_keywords
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk1 ON akat.movie_id = mk1.movie_id
JOIN keyword k1 ON mk1.keyword_id = k1.id
JOIN movie_keyword mk2 ON akat.movie_id = mk2.movie_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE ci.nr_order <= 16
  AND akat.production_year BETWEEN 2004 AND 2013
  AND n.name LIKE 'Stephens'
  AND rt.role = 'costume designer'
  AND k1.keyword LIKE '_tone-%'
  AND k2.keyword LIKE '_i_m%r%'
  AND c.name LIKE '_r%i%a_co'
  AND ct.kind IN ('miscellaneous companies', 'distributors', 'special effects companies', 'production companies')
  AND akat.title LIKE '% %je%i_ %'
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
