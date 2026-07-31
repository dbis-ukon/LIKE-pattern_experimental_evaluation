SELECT n.name, n.gender, COUNT(DISTINCT t.id) AS movies
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE t.production_year > 2006
  AND ci.role_id IN (5, 2, 8, 3, 1)
  AND ci.nr_order IS NOT NULL
  AND n.name LIKE 'Murdock'
  AND t.title LIKE 'Gr_en%ou%'
GROUP BY n.name, n.gender
HAVING COUNT(DISTINCT t.id) > 1
ORDER BY movies DESC;
