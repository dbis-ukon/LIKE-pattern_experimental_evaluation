SELECT c.id, c.name, t.title
FROM company_name c
JOIN movie_companies mc ON c.id = mc.company_id
JOIN title t ON mc.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE c.name LIKE 'A_ocaly_se Fi_m _rojects_Inc.'
  AND t.title LIKE 'Os_a_d%'
  AND (n.name LIKE 'Mann' or n.name LIKE '_a%' or n.name LIKE 'Farber')
  AND ci.role_id = 10
  AND t.production_year >= 2000;
