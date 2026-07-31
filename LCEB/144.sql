SELECT t.title, COUNT(DISTINCT n.id) AS actors
FROM title t
JOIN complete_cast cc ON cc.movie_id = t.id
JOIN name n ON n.id = cc.subject_id
WHERE t.title LIKE '_ass%e%a_a%n_e%'
  AND n.gender = 'f'
  AND t.production_year BETWEEN 1992 AND 1996
  AND t.kind_id IN (3, 7, 2, 1)
GROUP BY t.title
ORDER BY actors DESC;
