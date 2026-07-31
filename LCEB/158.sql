SELECT n.name, COUNT(DISTINCT ci.movie_id) AS lead_roles
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN role_type rt ON rt.id = ci.role_id
WHERE n.name LIKE '%n%Lydia' OR n.name LIKE 'Lév% Boris'
  AND rt.role LIKE '%Lead%'
  AND ci.nr_order <= 10
  AND n.gender = 'f'
GROUP BY n.name
ORDER BY lead_roles DESC;
