SELECT n.name, COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN movie_link ml ON ml.movie_id = ci.movie_id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE n.name LIKE 'Jo_ns%Den%'
  AND lt.link LIKE '%Spin-off%'
  AND n.gender = 'm'
GROUP BY n.name
ORDER BY linked_movies DESC;
