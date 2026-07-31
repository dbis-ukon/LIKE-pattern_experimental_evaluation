SELECT cn.name, rt.role, COUNT(DISTINCT ci.movie_id) AS role_count
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN role_type rt ON rt.id = ci.role_id
WHERE cn.name LIKE 'Camp%i c%s_e'
  AND rt.role LIKE '%Lead%'
  AND ci.nr_order <= 4
  AND ci.note IS NOT NULL
GROUP BY cn.name, rt.role
ORDER BY role_count DESC;
