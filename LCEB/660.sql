SELECT n.name, n.gender, COUNT(DISTINCT t.id) AS movies
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE t.title LIKE '%0%-0%'
  AND (n.name LIKE 'S_o% D%se' OR n.name LIKE 'Ber_o_cini_ Ivan')
  AND ci.role_id IN (4, 9, 10, 2, 8)
  AND ci.nr_order <= 14
  AND t.episode_nr <= 18
  AND t.kind_id = 3
  AND t.production_year BETWEEN 1968 AND 2007
GROUP BY n.name, n.gender
HAVING COUNT(DISTINCT t.id) > 1
ORDER BY movies DESC;
