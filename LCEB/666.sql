SELECT n.name, n.gender, COUNT(DISTINCT t.id) AS movies
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE t.title LIKE 'N_c_tine'
  AND t.episode_nr <= 24
  AND ci.nr_order <= 3
  AND n.gender = 'm'
  AND t.kind_id = 7
  AND t.production_year < 2004
  AND (n.name LIKE 'Mo%a_i' OR n.name LIKE 'Bazá_')
GROUP BY n.name, n.gender
HAVING COUNT(DISTINCT t.id) > 1
ORDER BY movies DESC;
