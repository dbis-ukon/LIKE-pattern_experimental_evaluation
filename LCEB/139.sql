SELECT t.title, lt.link, COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM title t
JOIN movie_link ml ON ml.movie_id = t.id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE t.title LIKE '_iving_Lo_g_r'
  AND lt.link LIKE '%Sequel%'
  AND ml.linked_movie_id IS NOT NULL
  AND t.production_year >= 2007
  AND t.kind_id IN (7, 2, 3, 1, 6)
GROUP BY t.title, lt.link
ORDER BY linked_movies DESC;
