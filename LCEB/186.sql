SELECT
    co.name AS company_name,
    t.title AS movie_title,
    rt.role AS main_role,
    COUNT(DISTINCT ci.person_id) AS actors_count
FROM company_name co
JOIN movie_companies mc ON co.id = mc.company_id
JOIN title t ON mc.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN char_name c ON ci.person_role_id = c.id
WHERE (co.name LIKE 'Scitech Cu_ture %mpany' OR co.name LIKE 'Arpa _ideo')
  AND c.name LIKE '%ô_S%'
  AND rt.role LIKE '%actor%'
  AND t.production_year >= 2005
GROUP BY co.name, t.title, rt.role
ORDER BY actors_count DESC;
