SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keyword_count,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    COUNT(DISTINCT mc.company_id) AS company_count
FROM title t
JOIN kind_type kt           ON t.kind_id = kt.id
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
JOIN complete_cast cc       ON t.id = cc.movie_id
JOIN comp_cast_type cct     ON cc.subject_id = cct.id
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
JOIN movie_info_idx mix     ON t.id = mix.movie_id
JOIN info_type it2          ON mix.info_type_id = it2.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
WHERE t.title LIKE '%c_i La%'
  AND akat.title LIKE 'Cal_gula: Funni_s_ _ome_V_deos'
  AND k.keyword LIKE '%f%e_t%g_j%-_ib%'
  AND c.name LIKE '% _r%s'
  AND n.name LIKE '_aku%M_zhet'
  AND cn.name LIKE '%al%'
  AND t.production_year BETWEEN 1969 AND 2001
  AND ci.nr_order <= 3
  AND rt.id = 5
  AND ct.id IN (2, 1, 3, 4)
  AND mi.info IS NOT NULL
  AND mix.info IS NOT NULL
GROUP BY t.id, t.title
ORDER BY keyword_count DESC;
