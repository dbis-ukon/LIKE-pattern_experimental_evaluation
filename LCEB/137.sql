SELECT t.title, rt.role, COUNT(DISTINCT ci.person_id) AS num_roles
FROM title t
JOIN cast_info ci ON ci.movie_id = t.id
JOIN role_type rt ON rt.id = ci.role_id
WHERE t.title LIKE 'L%o% _p'
  AND rt.role LIKE '%Lead%'
  AND ci.nr_order <= 2
  AND t.production_year >= 2005
  AND t.kind_id IN (2, 7, 1)
GROUP BY t.title, rt.role
ORDER BY num_roles DESC;
