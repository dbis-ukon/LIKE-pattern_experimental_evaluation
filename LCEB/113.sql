SELECT cn.name, lt.link, COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN movie_link ml ON ml.movie_id = ci.movie_id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE cn.name LIKE 'Mi_ha%'
  AND lt.link LIKE '%Prequel%'
  AND (ci.nr_order <= 7 OR ml.link_type_id IS NOT NULL)
GROUP BY cn.name, lt.link
ORDER BY linked_movies DESC;
