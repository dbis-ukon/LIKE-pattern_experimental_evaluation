SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (t.title LIKE 'E% _fi_s_s% K_et_' OR n.name LIKE 'Mall%eddus')
  AND t.kind_id IN (7, 4, 3, 1)
  AND k.keyword NOT LIKE 'me%ia_-he%o%it%'
  AND t.episode_nr <= 20
  AND n.gender = 'm'
  AND ci.role_id IN (8, 4, 7, 5, 2)
ORDER BY t.production_year DESC
LIMIT 200;
