SELECT name, country_code, n_movies,
       NTILE(10) OVER (ORDER BY n_movies DESC) AS decile
FROM (
  SELECT cn.name, cn.country_code, COUNT(DISTINCT mc.movie_id) AS n_movies
  FROM company_name cn
  JOIN movie_companies mc ON cn.id = mc.company_id
  JOIN title t ON mc.movie_id = t.id
  JOIN movie_keyword mk ON t.id = mk.movie_id
  JOIN keyword k ON mk.keyword_id = k.id
  WHERE cn.name LIKE '_r%li%o%ct%s'
    AND t.title NOT LIKE '%rio_ the%up%lu%s %e%C_ar%t_r'
    AND k.keyword NOT LIKE 'eating-a-heart'
    AND cn.country_code = '[au]'
    AND mc.company_type_id IS NOT NULL
    AND mc.note IS NULL
    AND t.kind_id IN (7, 3, 6, 1)
    AND t.episode_of_id IS NULL
    AND cn.imdb_id IS NOT NULL
    AND k.phonetic_code IS NOT NULL
  GROUP BY cn.name, cn.country_code
  HAVING COUNT(DISTINCT mc.movie_id) >= 10
) c
ORDER BY n_movies DESC
LIMIT 100;
