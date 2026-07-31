SELECT t.title, COUNT(DISTINCT ci.person_id) AS lead_roles
FROM title t
JOIN cast_info ci ON ci.movie_id = t.id
JOIN role_type rt ON rt.id = ci.role_id
WHERE (t.title LIKE '%n_esse_Ma_h_' OR t.title LIKE '(_00_-11-29)')
  AND rt.role LIKE '%Lead%'
  AND ci.nr_order <= 55
  AND t.production_year BETWEEN 1986 AND 2012
  AND t.kind_id IN (7, 3, 4, 1)
GROUP BY t.title
ORDER BY lead_roles DESC;
