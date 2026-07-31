SELECT co.name, rt.role, COUNT(DISTINCT ci.movie_id) AS role_count
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN cast_info ci ON ci.movie_id = mc.movie_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE co.name LIKE '_PS Telefilms'
  AND rt.role LIKE '%Lead%'
  AND ci.nr_order <= 13
  AND ci.note IS NOT NULL
GROUP BY co.name, rt.role
ORDER BY role_count DESC;
