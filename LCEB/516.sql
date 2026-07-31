SELECT
    t.id,
    t.title,
    COUNT(DISTINCT akat.id) AS alt_title_count,
    COUNT(DISTINCT k.id) AS keyword_count,
    COUNT(DISTINCT ci.person_id) AS cast_count
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
WHERE t.title LIKE '(2_1_-02-1_)'
  AND akat.title LIKE '_s%k%sil_a %lia_i_a'
  AND k.keyword LIKE 'cafe-bar'
  AND c.name LIKE '_v_n%f % St%s%n%tai%e%'
  AND n.name LIKE 'Darla_d'
  AND cn.name LIKE '_a%g% - %taché'
  AND t.production_year BETWEEN 1966 AND 2006
  AND t.kind_id IN (6, 4, 7, 1)
  AND c.country_code = '[us]'
  AND ct.id IN (4, 2, 1, 3)
  AND ci.nr_order <= 4
  AND rt.id = 4
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT k.id) >= 2
ORDER BY alt_title_count DESC;
