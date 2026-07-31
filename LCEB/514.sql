SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keyword_count,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    COUNT(DISTINCT mc.company_id) AS company_count
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
WHERE (t.title LIKE 'D%e%' OR t.title LIKE '%d%h_n_')
  AND akat.title LIKE 'Vitaphone Melody Master: Milt Britton and His World Famous Orchestra'
  AND k.keyword LIKE 'hitler-all_gory'
  AND c.name LIKE 'OZPIX Ent_r_a_nm_nt'
  AND n.name LIKE '_allo_t% A_sunt_'
  AND cn.name LIKE 'Det. Wilson'
  AND t.production_year BETWEEN 2008 AND 2010
  AND t.kind_id IN (2, 1, 7, 3)
  AND c.country_code = '[gb]'
  AND ct.id IN (2, 4, 3, 1)
  AND ci.nr_order <= 1
  AND rt.id = 5
  AND mi.info IS NOT NULL
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT k.id) > 3
ORDER BY keyword_count DESC;
