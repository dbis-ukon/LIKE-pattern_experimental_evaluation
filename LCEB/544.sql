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
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
WHERE akat.title LIKE 'The Two Hun_red and Twenty-Fifth_A_niversary of _he _an_ing_of th_ Hugueno_s at N_w Rochelle'
  AND t.title LIKE '(#1.164)'
  AND k.keyword LIKE '%-pa_l_-g%r'
  AND c.name LIKE '%G%l%'
  AND n.name LIKE '%d%g%'
  AND cn.name LIKE '_angler _oy #2'
  AND t.production_year >= 2011
  AND ci.nr_order BETWEEN 1 AND 14
  AND rt.id IN (11, 4, 10, 6, 8)
GROUP BY akat.movie_id
HAVING COUNT(DISTINCT ci.person_id) > 5
ORDER BY cast_size DESC;
