SELECT
    t.id,
    t.title,
    COUNT(DISTINCT ci.person_id) AS cast_members,
    COUNT(DISTINCT k.id) AS keyword_count,
    AVG(t.production_year) AS avg_year
FROM title t
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE 'Re_a%a_io%Hit'
  AND k.keyword LIKE 'e%l'
  AND n.name LIKE '_ayl_r%u_'
  AND cn.name LIKE '_a%l% %p%'
  AND ci.nr_order <= 5
  AND rt.id = 9
GROUP BY t.id, t.title
ORDER BY cast_members DESC;
