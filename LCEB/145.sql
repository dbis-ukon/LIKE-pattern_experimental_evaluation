SELECT t.title, COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM title t
JOIN movie_link ml ON ml.movie_id = t.id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE t.title LIKE '_e_ap_recid_'
  AND lt.link LIKE '%Spin-off%'
  AND ml.linked_movie_id IS NOT NULL
  AND t.production_year >= 2007
  AND t.kind_id IN (6, 1, 7, 3)
GROUP BY t.title
ORDER BY linked_movies DESC;
