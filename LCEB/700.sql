SELECT n1.name AS actress, COUNT(DISTINCT ci2.person_id) AS distinct_costars
FROM name n1
JOIN cast_info ci1 ON n1.id = ci1.person_id
JOIN cast_info ci2 ON ci1.movie_id = ci2.movie_id
                  AND ci1.person_id <> ci2.person_id
JOIN name n2 ON ci2.person_id = n2.id
JOIN title t ON ci1.movie_id = t.id
JOIN char_name cn ON ci1.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n1.gender = 'f'
  AND n2.gender IN ('m', 'f')
  AND (n1.name LIKE '%k%t%' OR n1.name LIKE '%r_as' OR n1.name LIKE 'Bacon')
  AND n2.name NOT LIKE 'Ro_erts'
  AND t.title NOT LIKE 'H_t%one _ %So%w_s_'
  AND cn.name LIKE '_i%lf_- _o_ _ew%R% %s_'
  AND k.keyword LIKE '%e_-%no%an%a%s'
  AND ci1.nr_order <= 2
  AND ci1.nr_order IS NOT NULL
  AND ci1.role_id IN (6, 3, 1, 8, 10)
  AND ci2.role_id IN (2, 10, 4, 1, 7)
  AND t.kind_id IN (1, 7)
  AND n1.imdb_id IS NOT NULL
GROUP BY n1.name
HAVING COUNT(DISTINCT ci2.person_id) >= 5
ORDER BY distinct_costars DESC
LIMIT 25;
