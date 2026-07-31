SELECT co.name, rt.role, COUNT(DISTINCT t.id) AS movies
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
JOIN cast_info ci ON ci.movie_id = t.id
JOIN role_type rt ON rt.id = ci.role_id
WHERE co.name LIKE 'Spri_g Street _roduc_ions'
  AND rt.role LIKE '%Lead%'
  AND t.production_year BETWEEN 2002 AND 2012
GROUP BY co.name, rt.role
ORDER BY movies DESC;
