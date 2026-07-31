SELECT n.name, t.title, t.production_year, pi.info
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE t.kind_id IN (7, 3, 1)
  AND t.episode_nr <= 16
  AND t.title LIKE '_new%'
  AND ci.nr_order <= 2
  AND t.production_year BETWEEN 1968 AND 2008
  AND ci.nr_order IS NOT NULL
  AND n.name LIKE '%le_'
ORDER BY t.production_year DESC
LIMIT 100;
