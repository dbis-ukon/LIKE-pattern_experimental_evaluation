SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.production_year BETWEEN 1964 AND 2012
  AND k.keyword LIKE '_l%-_e%-%'
  AND n.gender = 'm'
  AND ci.role_id IN (2, 1, 3, 4, 8)
  AND (t.title LIKE '_''ll%ke You to _un_h' OR n.name LIKE 'G_et_')
ORDER BY t.production_year DESC
LIMIT 200;
