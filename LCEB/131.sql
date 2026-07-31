SELECT co.name, lt.link, COUNT(DISTINCT ml.movie_id) AS linked_movies
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN movie_link ml ON ml.movie_id = mc.movie_id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE co.name LIKE '1st_M_r%e_G_o%inc_'
  AND lt.link LIKE '%Prequel%'
  AND ml.linked_movie_id IS NOT NULL
GROUP BY co.name, lt.link
ORDER BY linked_movies DESC;
