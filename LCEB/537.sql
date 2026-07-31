SELECT
    t.id,
    t.title,
    COUNT(DISTINCT akat.id) AS alt_title_count,
    COUNT(DISTINCT k.id) AS keyword_count,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    COUNT(DISTINCT mc.company_id) AS company_count,
    AVG(t.production_year) AS avg_year
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
JOIN movie_info_idx mix     ON t.id = mix.movie_id
JOIN info_type it2          ON mix.info_type_id = it2.id
WHERE t.title LIKE 'A_Moth_r''s _ove''s_a B_ess_ng'
  AND akat.title LIKE 'T_n%e%ro_'
  AND k.keyword LIKE '%ia'
  AND c.name LIKE '%S_u_io'
  AND n.name LIKE 'Spaini'
  AND cn.name LIKE 'Mát%i _ar_tja'
  AND t.production_year BETWEEN 1989 AND 1996
GROUP BY t.id, t.title
ORDER BY alt_title_count DESC;
