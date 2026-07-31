SELECT country_code, name, n_movies, rnk
FROM (
  SELECT cn.country_code, cn.name,
         COUNT(DISTINCT mc.movie_id) AS n_movies,
         RANK() OVER (PARTITION BY cn.country_code
                      ORDER BY COUNT(DISTINCT mc.movie_id) DESC) AS rnk
  FROM company_name cn
  JOIN movie_companies mc ON cn.id = mc.company_id
  JOIN title t ON mc.movie_id = t.id
  JOIN movie_keyword mk ON t.id = mk.movie_id
  JOIN keyword k ON mk.keyword_id = k.id
  WHERE (cn.name LIKE '%homo%' OR cn.name LIKE 'Li%o_ %t%t%n%n_')
    AND t.title NOT LIKE '(200%)'
    AND k.keyword LIKE 'w_i%'
    AND cn.country_code IS NOT NULL
    AND mc.company_type_id IN (1, 2)
    AND mc.note IS NULL
    AND t.kind_id IN (6, 7, 1, 2)
    AND t.episode_of_id IS NULL
    AND cn.imdb_id IS NOT NULL
  GROUP BY cn.country_code, cn.name
) ranked
WHERE rnk <= 5
ORDER BY country_code, rnk;
