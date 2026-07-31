SELECT
    n.name,
    COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN movie_link ml ON ml.movie_id = ci.movie_id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE n.name LIKE 'Goll'
  AND lt.link LIKE '%Sequel%'
  AND n.gender = 'm'
  AND ci.nr_order <= 3
GROUP BY n.name
ORDER BY linked_movies DESC;
