SELECT
    akat.title,
    COUNT(DISTINCT t2.id) AS linked_movies,
    MIN(t.production_year) AS first_year
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE akat.title LIKE '_''Agg%o'
  AND (t.title LIKE 'The Do_zers' or t.title LIKE 'For t%e_rt o_ a Princess' )
  AND k.keyword LIKE 'ca_-_k_d'
  AND c.name LIKE 'Avistaar'
  AND t.production_year >= 1911
  AND mc.company_type_id = 2
GROUP BY akat.title
ORDER BY linked_movies DESC;
