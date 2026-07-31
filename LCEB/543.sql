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
JOIN movie_info_idx mix     ON t.id = mix.movie_id
JOIN info_type it2          ON mix.info_type_id = it2.id
WHERE t.title LIKE '(%1_-1%26_'
  AND akat.title LIKE '%e_d%d_m%ays _i%B%l_'
  AND k.keyword LIKE 'ozon_-_ole'
  AND c.name LIKE 'Glo_a_ V_ew Product_ons'
  AND n.name LIKE 'Penze%Ha%-%rner'
  AND cn.name LIKE '%ab_l%uena_ent_ra'
  AND t.production_year BETWEEN 1996 AND 2012
  AND ci.nr_order <= 12
  AND rt.id = 10
  AND ct.id IN (1, 2, 4, 3)
  AND mi.info IS NOT NULL
  AND mix.info IS NOT NULL
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT k.id) > 3
ORDER BY keyword_count DESC;
