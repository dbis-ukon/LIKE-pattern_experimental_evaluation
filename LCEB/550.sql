SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keyword_count,
    SUM(CASE WHEN n.gender='F' THEN 1 ELSE 0 END) AS female_cast,
    COUNT(DISTINCT mc.company_id) AS company_count
FROM title t
JOIN kind_type kt           ON t.kind_id = kt.id
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN company_type ct        ON mc.company_type_id = ct.id
JOIN complete_cast cc       ON t.id = cc.movie_id
JOIN comp_cast_type cct     ON cc.subject_id = cct.id
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
JOIN movie_info_idx mix     ON t.id = mix.movie_id
JOIN info_type it2          ON mix.info_type_id = it2.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
WHERE t.title LIKE '%n_a%We%z% H%e%l%'
  AND akat.title LIKE '%n%d% A%sen_b_üh''_'
  AND k.keyword LIKE '%ec%a%'
  AND n.name LIKE 'B_row%'
  AND cn.name LIKE 'Sgt. Dreyfus'
  AND c.name LIKE 'M_nister_o%e%ducac_ó%de%Na%ó_'
  AND t.production_year BETWEEN 1987 AND 2008
  AND ci.nr_order <= 57
GROUP BY t.id, t.title
ORDER BY keyword_count DESC;
