SELECT
    t.title,
    COUNT(DISTINCT mc.company_id) AS company_count,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    AVG(t.production_year) AS avg_year
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
WHERE t.title LIKE 'C%e%C%n_'
  AND akat.title LIKE '%e_i%n Y% _I'
  AND k.keyword LIKE 'l_avin_-_ote'
  AND n.name LIKE 'S_t_i%d'
  AND cn.name LIKE '%B%ta%e_'
  AND c.name LIKE '%t%s%i%'
  AND t.production_year >= 2009
  AND ci.nr_order BETWEEN 1 AND 3
GROUP BY t.title
HAVING COUNT(DISTINCT mc.company_id) > 1
ORDER BY company_count DESC;
