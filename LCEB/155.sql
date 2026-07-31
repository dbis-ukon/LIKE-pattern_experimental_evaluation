SELECT cn.name, rt.role, COUNT(DISTINCT ci.movie_id) AS roles
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN role_type rt ON rt.id = ci.role_id
JOIN title t ON t.id = ci.movie_id
WHERE cn.name LIKE 'R_d%fo Reyes'
  AND rt.role LIKE '%Supporting%'
  AND ci.nr_order <= 1
  AND t.production_year BETWEEN 1996 AND 2012
  AND t.kind_id IN (6, 3, 7, 1)
GROUP BY cn.name, rt.role
ORDER BY roles DESC;
