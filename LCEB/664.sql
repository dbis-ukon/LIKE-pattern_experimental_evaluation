SELECT n.name, t.title, t.production_year, pi.info
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE (n.name LIKE '%a%ot_' OR n.name LIKE 'Har_is')
  AND t.season_nr IS NULL
  AND t.kind_id = 7
  AND ci.role_id IN (1, 3, 10, 2, 8)
  AND t.title NOT LIKE '_o%e_e%i%'
ORDER BY t.production_year DESC
LIMIT 100;
