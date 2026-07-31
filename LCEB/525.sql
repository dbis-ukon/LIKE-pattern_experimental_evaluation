SELECT
    t.id,
    t.title,
    COUNT(DISTINCT ci.person_id) AS cast_members,
    COUNT(DISTINCT mc.company_id) AS companies
FROM title t
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
WHERE t.title LIKE '%7_-_1_2_)'
  AND n.name LIKE 'White'
  AND cn.name LIKE 'Lt.%aws%'
  AND k.keyword LIKE '_ncient-china'
  AND c.name LIKE '_l% _a%f%'
  AND rt.id = 8
GROUP BY t.id, t.title
ORDER BY cast_members DESC;
