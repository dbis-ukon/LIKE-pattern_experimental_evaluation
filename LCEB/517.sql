SELECT
    akat.movie_id,
    MAX(t.production_year) AS latest_year,
    COUNT(DISTINCT mc.company_id) AS companies,
    COUNT(DISTINCT k.id) AS keywords
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN company_type ct        ON mc.company_type_id = ct.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN char_name cn           ON ci.person_role_id = cn.id
WHERE akat.title LIKE 'Oma%uss_a%Im%'
  AND t.title LIKE 'Plant Hunter'
  AND k.keyword LIKE 'night-_i_i_g'
  AND c.name LIKE '_ote%i_ Pi_tures'
  AND n.name LIKE '_in_er_ Mauri_s'
  AND cn.name LIKE 'Elijah''s Thu_ 1'
  AND t.production_year >= 1951
  AND c.country_code IN ('[be]', '[jp]', '[mx]', '[fr]', '[nz]')
  AND ct.id = 2
  AND ci.nr_order BETWEEN 9 AND 11
  AND rt.id IN (10, 4, 2, 8, 6)
GROUP BY akat.movie_id
HAVING COUNT(DISTINCT mc.company_id) > 1
ORDER BY latest_year DESC;
