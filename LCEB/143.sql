SELECT t.title, rt.role, COUNT(DISTINCT ci.person_id) AS roles
FROM title t
JOIN cast_info ci ON ci.movie_id = t.id
JOIN role_type rt ON rt.id = ci.role_id
WHERE t.title LIKE 'Radia_i_n_Wave_'
  AND rt.role LIKE '%Supporting%'
  AND ci.nr_order <= 0
  AND t.production_year >= 1995
  AND t.kind_id IN (1, 4, 3, 7)
GROUP BY t.title, rt.role
ORDER BY roles DESC;
