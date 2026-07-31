SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keyword_count,
    COUNT(DISTINCT ci.person_id) AS cast_size
FROM title t
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE 'Bad %lf _y_Way'
  AND k.keyword LIKE 'dy_ng-during-sex'
  AND n.name LIKE '%e%nd%'
  AND cn.name LIKE '%c%a%a%r'
  AND c.name LIKE 'Prada Films'
  AND t.production_year BETWEEN 2001 AND 2003
GROUP BY t.id, t.title
ORDER BY keyword_count DESC;
