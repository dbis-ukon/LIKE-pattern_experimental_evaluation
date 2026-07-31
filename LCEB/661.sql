SELECT n.name, t.title, t.production_year, pi.info
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE t.title LIKE 'R_mp%el H%vo'
  AND n.gender = 'f'
  AND t.production_year BETWEEN 1951 AND 2005
  AND ci.role_id IN (2, 10, 1, 4, 3)
  AND n.name LIKE 'O%c%'
ORDER BY t.production_year DESC
LIMIT 100;
