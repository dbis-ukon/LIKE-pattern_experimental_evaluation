SELECT cn.name, COUNT(DISTINCT ci.movie_id) AS movie_count
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN title t ON t.id = ci.movie_id
WHERE (cn.name LIKE 'E%ca' OR cn.name LIKE 'Krist%th_ %ado_binder')
  AND t.production_year BETWEEN 2011 AND 2013
  AND ci.nr_order <= 11
  AND t.kind_id IN (4, 1, 2, 6, 7)
GROUP BY cn.name
ORDER BY movie_count DESC;
