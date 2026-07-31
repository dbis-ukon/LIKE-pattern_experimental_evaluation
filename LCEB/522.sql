SELECT
    akat.movie_id,
    MAX(t.production_year) AS latest_year,
    COUNT(DISTINCT mc.company_id) AS companies
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
WHERE akat.title LIKE 'The_Lu_ky_Numb_r'
  AND t.title LIKE '(#1.761)'
  AND k.keyword LIKE '_r%n%n_'
  AND c.name LIKE 'Neo_ino'
  AND n.name LIKE 'Bazzo_i'
  AND cn.name LIKE '% %r_i%'
  AND t.kind_id = 7
GROUP BY akat.movie_id
ORDER BY latest_year DESC;
