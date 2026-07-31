SELECT n.name, COUNT(DISTINCT ml.movie_id) AS linked_movies, MAX(a.production_year) AS last_year
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN movie_link ml ON ml.movie_id = ci.movie_id
JOIN link_type lt ON lt.id = ml.link_type_id
JOIN aka_title a ON a.movie_id = ci.movie_id
WHERE n.name LIKE '%i%'
  AND lt.link LIKE '%Remake%'
  AND n.gender = 'f'
  AND a.production_year >= 2003
GROUP BY n.name
ORDER BY linked_movies DESC;
