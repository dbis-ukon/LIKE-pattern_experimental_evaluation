SELECT a.title, COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM aka_title a
JOIN movie_link ml ON ml.movie_id = a.movie_id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE a.title LIKE 'T_a%re_dir_'
  AND lt.link LIKE '%Sequel%'
  AND a.production_year >= 1997
GROUP BY a.title
ORDER BY linked_movies DESC;
