SELECT cn.name, rt.role, COUNT(DISTINCT ci.movie_id) AS num_movies
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN role_type rt ON rt.id = ci.role_id
JOIN title t ON t.id = ci.movie_id
WHERE cn.name LIKE 'Le_ D_A%ssio'
  AND rt.role LIKE '%Lead%'
  AND ci.nr_order <= 3
  AND t.production_year BETWEEN 1962 AND 1988
  AND t.kind_id IN (1, 3, 7)
GROUP BY cn.name, rt.role
ORDER BY num_movies DESC;
