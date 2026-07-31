SELECT t.title, COUNT(DISTINCT n.id) AS actors
FROM title t
JOIN complete_cast cc ON cc.movie_id = t.id
JOIN name n ON n.id = cc.subject_id
WHERE t.title LIKE '%0_0-0_-2_)'
  AND n.gender = 'm'
  AND t.production_year BETWEEN 1912 AND 2008
  AND cc.status_id IS NOT NULL
  AND t.kind_id IN (1, 3, 2, 7)
GROUP BY t.title
ORDER BY actors DESC;
