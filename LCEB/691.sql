SELECT cn.name AS character_name, COUNT(DISTINCT ci.person_id) AS n_actors
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_role_id
JOIN title t ON ci.movie_id = t.id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (cn.name LIKE '% _ö_k' OR cn.name LIKE 'Mary Nell D_dge' OR cn.name LIKE 'Carla M%i%y')
  AND t.title NOT LIKE '%k%u %i%j%!_'
  AND n.name LIKE '_i%g_'
  AND k.keyword LIKE '_rugstore'
  AND co.name LIKE '_inevox'
  AND ci.nr_order <= 9
  AND ci.nr_order IS NOT NULL
  AND n.gender IN ('m', 'f')
  AND ci.role_id IN (6, 1, 7, 2, 4)
  AND co.country_code IN ('[fi]', '[ca]', '[ph]', '[gb]', '[mx]')
  AND t.kind_id IN (2, 3, 7, 1, 4)
  AND cn.md5sum IS NOT NULL
GROUP BY cn.name
HAVING COUNT(DISTINCT ci.person_id) >= 3
ORDER BY n_actors DESC
LIMIT 30;
