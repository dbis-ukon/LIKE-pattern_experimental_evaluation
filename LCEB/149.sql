SELECT t.title, COUNT(DISTINCT k.id) AS num_keywords, MAX(t.production_year) AS last_year
FROM title t
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE (t.title LIKE 'Odcinek 7_6' OR t.title LIKE 'T%s:%bu_d_nt_L_f_ %ni_tr_e_')
  AND k.keyword LIKE '_ymbalom'
  AND t.production_year BETWEEN 1961 AND 2007
  AND t.kind_id IN (1, 7)
GROUP BY t.title
ORDER BY last_year DESC;
