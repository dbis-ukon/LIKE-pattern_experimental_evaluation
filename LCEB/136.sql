SELECT t.title, COUNT(DISTINCT k.id) AS keywords
FROM title t
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE t.title LIKE 'T%Te%s M_rs_a_'
  AND k.keyword LIKE 'y_o_'
  AND t.production_year BETWEEN 2008 AND 2012
  AND t.kind_id IN (1, 3, 7)
GROUP BY t.title
ORDER BY keywords DESC;
