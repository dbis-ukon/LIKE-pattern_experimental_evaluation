SELECT
    akat.title,
    COUNT(DISTINCT t2.id) AS related_movies,
    COUNT(DISTINCT k.id) AS keyword_count,
    SUM(CASE WHEN n.gender='M' THEN 1 ELSE 0 END) AS male_cast
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_link ml          ON t.id = ml.movie_id
JOIN link_type lt           ON ml.link_type_id = lt.id
JOIN title t2               ON ml.linked_movie_id = t2.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
WHERE akat.title LIKE '%l%m% i%Rapi%'
  AND t.title LIKE 'Minnie Red%ding Hood'
  AND k.keyword LIKE 's_eep_ask'
  AND n.name LIKE 'Turk_ru_'
  AND cn.name LIKE 'Tye_sha%rtin'
  AND ci.nr_order <= 3
  AND t.production_year >= 1985
GROUP BY akat.title
HAVING COUNT(DISTINCT t2.id) >= 1
ORDER BY keyword_count DESC;
