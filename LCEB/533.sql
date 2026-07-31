SELECT
    t.id,
    t.title,
    COUNT(DISTINCT mc.company_id) AS companies,
    COUNT(DISTINCT k.id) AS keywords,
    COUNT(DISTINCT ci.person_id) AS cast_count
FROM title t
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
WHERE t.title LIKE 'Bummer'
  AND k.keyword LIKE 't_oisvierges'
  AND c.name LIKE '_e%ma_h_s'
  AND n.name LIKE 'V_l_r% María Jes%'
  AND cn.name LIKE 'Marie %ding'
  AND t.production_year BETWEEN 1956 AND 2006
  AND mc.company_type_id IN (2, 1)
  AND ci.nr_order <= 19
GROUP BY t.id, t.title
ORDER BY keywords DESC;
