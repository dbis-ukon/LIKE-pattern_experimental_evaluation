SELECT k.keyword, lt.link, COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM keyword k
JOIN movie_keyword mk ON mk.keyword_id = k.id
JOIN title t ON t.id = mk.movie_id
JOIN movie_link ml ON ml.movie_id = t.id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE k.keyword LIKE '%den-_e_ade%f%o%graph_'
  AND lt.link LIKE '%Sequel%'
  AND t.production_year >= 2011
  AND t.season_nr IS NOT NULL
GROUP BY k.keyword, lt.link
ORDER BY linked_movies DESC;
