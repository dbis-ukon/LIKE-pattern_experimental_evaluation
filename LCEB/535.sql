SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keyword_count,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    MAX(t.production_year) AS latest_year,
    COUNT(DISTINCT mc.company_id) AS company_count
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
JOIN movie_info_idx mix     ON t.id = mix.movie_id
JOIN info_type it2          ON mix.info_type_id = it2.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
WHERE t.title LIKE 'A _cien%ic Moth%'
  AND akat.title LIKE '%o_e e_a_tr_ _at_st%fi'
  AND k.keyword LIKE 'reference%nt_-_laus'
  AND c.name LIKE 'T_M _ilm C.A_'
  AND n.name LIKE 'Harl_w'
  AND cn.name LIKE 'S_eriff_G_orge Gle_n'
  AND t.production_year BETWEEN 1999 AND 2005
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT k.id) > 3
ORDER BY keyword_count DESC;
