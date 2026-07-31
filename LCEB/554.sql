SELECT
    akat.title,
    COUNT(DISTINCT t2.id) AS related_movies,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    COUNT(DISTINCT mc.company_id) AS company_count
FROM title t
JOIN aka_title akat            ON t.id = akat.movie_id
JOIN movie_link ml           ON t.id = ml.movie_id
JOIN link_type lt            ON ml.link_type_id = lt.id
JOIN title t2                ON ml.linked_movie_id = t2.id
JOIN movie_keyword mk        ON t.id = mk.movie_id
JOIN keyword k               ON mk.keyword_id = k.id
JOIN movie_companies mc      ON t.id = mc.movie_id
JOIN company_name c          ON mc.company_id = c.id
JOIN company_type ct         ON mc.company_type_id = ct.id
JOIN cast_info ci            ON t.id = ci.movie_id
JOIN name n                  ON ci.person_id = n.id
JOIN role_type rt            ON ci.role_id = rt.id
JOIN char_name cn            ON ci.person_role_id = cn.id
JOIN complete_cast cc        ON t.id = cc.movie_id
JOIN comp_cast_type cct      ON cc.status_id = cct.id
JOIN movie_info mi           ON t.id = mi.movie_id
JOIN info_type it            ON mi.info_type_id = it.id
JOIN movie_info_idx mix      ON t.id = mix.movie_id
JOIN info_type it2           ON mix.info_type_id = it2.id
WHERE akat.title LIKE 'T_e_H_ppopot_m_s Para_e'
  AND t.title LIKE '(#%.3_)'
  AND k.keyword LIKE '%e_idenc_'
  AND n.name LIKE 'Mee_in_ Pau_'
  AND cn.name LIKE '%se% _ia_on%i%'
  AND t.production_year >= 1971
  AND ci.nr_order <= 13
  AND rt.id = 2
GROUP BY akat.title
ORDER BY related_movies DESC;
