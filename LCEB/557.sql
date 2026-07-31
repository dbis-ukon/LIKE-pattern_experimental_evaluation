SELECT
    t.id,
    t.title,
    COUNT(DISTINCT akat.id) AS alt_title_count,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    COUNT(DISTINCT mc.company_id) AS company_count
FROM title t
JOIN kind_type kt           ON t.kind_id = kt.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN company_type ct        ON mc.company_type_id = ct.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN complete_cast cc       ON t.id = cc.movie_id
JOIN comp_cast_type cct     ON cc.subject_id = cct.id
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
JOIN movie_info_idx mix     ON t.id = mix.movie_id
JOIN info_type it2          ON mix.info_type_id = it2.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
WHERE t.production_year >= 1951
  AND ci.nr_order BETWEEN 2 AND 4
  AND rt.id IN (12, 6, 9, 4, 10)
  AND t.title LIKE '%c_i La%'
  AND akat.title LIKE 'J-_orror Theater Vol.%'
  AND k.keyword LIKE '_arn_val-gang%ont'
  AND n.name LIKE 'Åman_ Ja_'
  AND cn.name LIKE '_e_th%e%'
GROUP BY t.id, t.title
ORDER BY alt_title_count DESC;
