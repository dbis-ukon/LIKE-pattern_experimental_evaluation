SELECT
    n.name,
    COUNT(DISTINCT ci.movie_id) AS lead_roles
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN role_type rt ON ci.role_id = rt.id
WHERE n.name LIKE '%mada%'
  AND rt.role LIKE '%Lead%'
  AND ci.nr_order <= 18
  AND n.gender = 'f'
GROUP BY n.name
ORDER BY lead_roles DESC;
