SELECT
    t.title,
    COUNT(DISTINCT ci.person_id) AS main_cast,
    COUNT(DISTINCT k.id) AS keywords,
    MIN(t.production_year) AS first_year
FROM title t
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE 'T_e Last O%'
  AND k.keyword LIKE 'l_ot'
  AND n.name LIKE '_l%'
  AND cn.name LIKE '_avid%a%e'
  AND c.name LIKE 'C%ve%B%n_'
  AND t.production_year >= 2005
GROUP BY t.title
ORDER BY main_cast DESC;
