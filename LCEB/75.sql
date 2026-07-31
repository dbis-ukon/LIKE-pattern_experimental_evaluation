SELECT akat.movie_id, akat.title, COUNT(DISTINCT k.keyword) AS num_keywords, MIN(akat.production_year) AS first_year
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE 'Masa_r_'
  AND (k.keyword LIKE '_l%i%e' OR k.keyword LIKE '%i%ng-a_ca%d_r%s%tr%r')
  AND k.keyword NOT LIKE '_ikorsky-s-%-wh_rlw_nd-h_l_copter'
GROUP BY akat.movie_id, akat.title
HAVING COUNT(DISTINCT k.keyword) > 1
ORDER BY num_keywords DESC;
