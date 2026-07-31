SELECT
    akat.title,
    COUNT(DISTINCT t2.id) AS related_movies,
    COUNT(DISTINCT k.id) AS keyword_count
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN company_type ct        ON mc.company_type_id = ct.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN char_name cn           ON ci.person_role_id = cn.id
WHERE akat.title LIKE '_ _ed% _o_ _h_r_'
  AND t.title LIKE 'A_ianzas estratégicas'
  AND k.keyword LIKE '_o_i%n_t%'
  AND c.name LIKE '%gic%il%'
  AND n.name LIKE 'Rivette'
  AND cn.name LIKE 'Lu_y _e_emeyer'
  AND t.production_year >= 2002
  AND t.kind_id IN (7, 2, 1, 6)
  AND c.country_code = '[us]'
  AND ct.id = 1
  AND ci.nr_order <= 19
  AND rt.id = 11
GROUP BY akat.title
HAVING COUNT(DISTINCT t2.id) >= 1
ORDER BY keyword_count DESC;
