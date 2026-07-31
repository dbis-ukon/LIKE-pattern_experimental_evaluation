SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE k.phonetic_code IS NOT NULL
  AND ci.role_id IN (3, 5, 1, 2, 4)
  AND n.gender = 'm'
  AND k.keyword NOT LIKE 'ko%an%mm_ni%'
  AND (t.title LIKE 'Ho_inid' OR n.name LIKE 'W_gner_ %y')
  AND t.episode_nr <= 143
ORDER BY t.production_year DESC
LIMIT 200;
