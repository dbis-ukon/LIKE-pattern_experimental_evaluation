SELECT
    n.name,
    MAX(a.production_year) AS last_movie,
    COUNT(DISTINCT k.id) AS num_keywords
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN aka_title a ON a.movie_id = ci.movie_id
JOIN movie_keyword mk ON mk.movie_id = a.movie_id
JOIN keyword k ON k.id = mk.keyword_id
WHERE n.name LIKE 'Bäfver'
  AND n.name LIKE '_li%ira_ _a_ia%gênia'
  AND a.episode_nr > 3
  AND ci.nr_order < 19
GROUP BY n.name
ORDER BY last_movie DESC;
