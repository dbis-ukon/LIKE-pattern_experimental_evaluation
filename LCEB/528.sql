SELECT
    akat.title,
    COUNT(DISTINCT ci.person_id) AS main_cast,
    COUNT(DISTINCT k.id) AS keywords,
    MAX(t.production_year) AS last_year
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE akat.title LIKE '_lom% _i_ _oc_te%r %d%'
  AND t.title LIKE '_1%9-03-_3)'
  AND k.keyword LIKE '_r%by'
  AND n.name LIKE 'Hejl'
  AND cn.name LIKE '%R_mos'
  AND c.name LIKE 'Bub%r_ P%duct%n_'
GROUP BY akat.title
ORDER BY last_year DESC;
