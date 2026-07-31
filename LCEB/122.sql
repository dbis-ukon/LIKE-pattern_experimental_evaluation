SELECT co.name, k.keyword, COUNT(DISTINCT t.id) AS keyword_movies
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE co.name LIKE '% %d%i%'
  AND k.keyword LIKE '_ast-f%ia'
  AND t.production_year BETWEEN 2003 AND 2012
GROUP BY co.name, k.keyword
ORDER BY keyword_movies DESC;
