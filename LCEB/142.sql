SELECT t.title, COUNT(DISTINCT k.id) AS num_keywords
FROM title t
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE (t.title LIKE 'No M_ H_l%' OR t.title LIKE 'C%s%n')
  AND k.keyword LIKE '_ut_-s_a_e'
  AND t.production_year BETWEEN 1988 AND 1989
  AND t.kind_id IN (2, 4, 1, 7)
GROUP BY t.title
ORDER BY num_keywords DESC;
