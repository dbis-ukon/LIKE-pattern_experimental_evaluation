SELECT
    akat.movie_id,
    MIN(t.production_year) AS year,
    COUNT(DISTINCT ci.person_id) AS cast_size,
    MAX(mc.company_id) AS max_company
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
WHERE akat.title LIKE 'It%e_an in_Spa%'
  AND t.title LIKE 'Tho_ough_reds'
  AND k.keyword LIKE 'f%-_e%o_'
  AND c.name LIKE 'Gar _il_'
  AND n.name LIKE '_u%a%e%c%'
  AND cn.name LIKE 'N% %e_'
  AND t.production_year >= 1912
  AND c.country_code IN ('[ca]', '[dk]', '[cl]', '[lv]', '[us]')
  AND ct.id = 4
  AND ci.nr_order BETWEEN 1 AND 8
  AND rt.id IN (11, 3, 6, 2, 10)
  AND t.kind_id = 1
GROUP BY akat.movie_id
HAVING COUNT(DISTINCT ci.person_id) > 5
ORDER BY cast_size DESC;
