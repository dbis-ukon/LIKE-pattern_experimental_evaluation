SELECT
    akat.title,
    COUNT(DISTINCT ci.person_id) AS cast_size,
    COUNT(DISTINCT t2.id) AS related_movies
FROM aka_title akat
JOIN title t           ON akat.movie_id = t.id
JOIN movie_link ml     ON t.id = ml.movie_id
JOIN title t2          ON ml.linked_movie_id = t2.id
JOIN cast_info ci      ON t.id = ci.movie_id
JOIN name n            ON ci.person_id = n.id
JOIN movie_keyword mk  ON t.id = mk.movie_id
JOIN keyword k         ON mk.keyword_id = k.id
WHERE t.kind_id = 3
  AND t.production_year BETWEEN 1969 AND 2006
  AND akat.title LIKE 'I%ma_cher_s'
  AND t.title LIKE '_hamp%nerl%e_'
  AND k.keyword LIKE '_uck-_ogers'
  AND n.name LIKE '_a_em'
GROUP BY akat.title
ORDER BY cast_size DESC;
