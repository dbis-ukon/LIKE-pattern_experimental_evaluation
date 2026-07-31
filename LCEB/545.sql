SELECT
    t.id,
    t.title,
    COUNT(DISTINCT akat.id) AS alt_title_count,
    COUNT(DISTINCT k.id) AS keyword_count,
    SUM(CASE WHEN n.gender='F' THEN 1 ELSE 0 END) AS female_cast
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE '_o%a%p%t_'
  AND akat.title LIKE 'Th_ %r%'
  AND k.keyword LIKE 'du_t_-_oad'
  AND n.name LIKE 'Frazier _ling_nsmith'
  AND cn.name LIKE 'L_-%i%Sung'
  AND c.name LIKE 'Or%in_l Productions'
  AND t.production_year BETWEEN 2006 AND 2006
  AND ci.nr_order <= 1
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT k.id) >= 2
ORDER BY alt_title_count DESC;
