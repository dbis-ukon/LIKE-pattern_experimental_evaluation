SELECT
    akat.title,
    COUNT(DISTINCT t2.id) AS linked_movies,
    COUNT(DISTINCT k.id) AS keywords
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE akat.title LIKE 'W. Somerset Maugham''s The Mo_n and Si_pence'
  AND t.title LIKE '(1985-08-02)'
  AND k.keyword LIKE 'cataplexy'
  AND c.name LIKE '_ni%itr%'
GROUP BY akat.title
ORDER BY linked_movies DESC;
