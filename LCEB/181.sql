SELECT
    t.title,
    lt.link AS sequel_link,
    rt.role AS main_role,
    COUNT(DISTINCT cc.subject_id) AS actors_count
FROM title t
JOIN movie_link ml ON t.id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN complete_cast cc ON t.id = cc.movie_id
WHERE lt.link LIKE '%sequel%'
  AND rt.role LIKE '%actor%'
  AND t.production_year >= 2011
GROUP BY t.title, lt.link, rt.role
ORDER BY actors_count DESC;
