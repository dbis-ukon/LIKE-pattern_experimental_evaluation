SELECT a.title, COUNT(DISTINCT ml.movie_id) AS spin_offs
FROM aka_title a
JOIN movie_link ml ON ml.movie_id = a.movie_id
JOIN link_type lt ON lt.id = ml.link_type_id
WHERE a.title LIKE '%r_h%nd So_th I_I'
  AND lt.link LIKE '%Spin-off%'
  AND a.production_year >= 1938
GROUP BY a.title
ORDER BY spin_offs DESC;
