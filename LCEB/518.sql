SELECT
    t.title,
    MIN(it.id) AS info_type_min,
    COUNT(DISTINCT ci.person_id) AS cast_size,
    COUNT(DISTINCT akat.id) AS alt_titles
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN company_type ct        ON mc.company_type_id = ct.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
WHERE t.title LIKE 'C_c%i_ _a%e'
  AND akat.title LIKE '%vi%et_o%e%ono%le'
  AND k.keyword LIKE '%os_d%i_d_d'
  AND c.name LIKE 'Just Caus_ Productions'
  AND n.name LIKE '_ay'
  AND cn.name LIKE 'G_s_a_ R_mbro_s_i'
  AND t.production_year BETWEEN 1999 AND 2011
  AND t.kind_id = 7
  AND c.country_code = '[dk]'
  AND ct.id IN (1, 2, 3, 4)
  AND ci.nr_order <= 11
  AND rt.id = 2
GROUP BY t.title
HAVING COUNT(DISTINCT ci.person_id) > 4
ORDER BY cast_size DESC;
