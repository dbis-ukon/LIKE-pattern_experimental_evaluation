SELECT
    t.id,
    t.title,
    COUNT(DISTINCT mi.id) AS info_rows,
    COUNT(DISTINCT ci.person_id) AS cast_members
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
WHERE t.title LIKE 'Viva Mex_co_y su_ _o%id_s'
  AND akat.title LIKE 'Aband%ed Wo_an'
  AND k.keyword LIKE '%la%'
  AND c.name LIKE 'Am%K%'
  AND n.name LIKE 'Houghton'
  AND cn.name LIKE 'S_n%an_W_m_n'
  AND t.production_year BETWEEN 1949 AND 1988
  AND t.kind_id = 7
  AND c.country_code IN ('[fi]', '[ca]', '[nl]', '[us]', '[gb]')
  AND ct.id IN (2, 3, 4, 1)
  AND ci.nr_order <= 2
  AND rt.id = 10
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT mi.id) > 2
ORDER BY cast_members DESC;
