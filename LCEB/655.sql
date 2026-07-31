SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.production_year >= 2011
  AND k.keyword LIKE '%ke-_umber_plate'
  AND t.episode_nr <= 134
  AND (t.title LIKE 'Escape _ro_ _e_l' OR n.name LIKE 'Sta_kevitz')
  AND ci.nr_order IS NOT NULL
ORDER BY t.production_year DESC
LIMIT 200;
