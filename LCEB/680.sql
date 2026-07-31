SELECT n.id, n.name, n.gender, COUNT(DISTINCT t.id) AS n_films
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name cn ON mc.company_id = cn.id
WHERE n.name LIKE '_eorg_s_n_ %ler_e'
  AND k.keyword LIKE 'f%-w%m%sel'
  AND cn.name LIKE 'A%an_ KG'
  AND t.title NOT LIKE '_201%1-%)'
  AND n.gender IN ('f', 'm')
  AND ci.nr_order <= 12
  AND ci.nr_order IS NOT NULL
  AND ci.role_id IN (2, 1, 4, 10, 3)
  AND cn.country_code = '[th]'
  AND mc.note IS NULL
  AND t.kind_id IN (7, 1, 2)
  AND n.imdb_id IS NOT NULL
GROUP BY n.id, n.name, n.gender
HAVING COUNT(DISTINCT t.id) >= 3
ORDER BY n_films DESC
LIMIT 30;
