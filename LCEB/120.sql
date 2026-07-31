SELECT co.name, COUNT(DISTINCT t.id) AS movie_count
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE (co.name LIKE 'Post W%ld%ustr%s' OR co.name LIKE 'MM Ma_hem Films')
  AND t.production_year BETWEEN 1996 AND 2010
GROUP BY co.name
ORDER BY movie_count DESC;
