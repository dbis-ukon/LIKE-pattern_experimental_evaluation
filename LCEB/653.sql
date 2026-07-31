SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE k.keyword LIKE 'mus_a%'
  AND (t.title LIKE 'Memoi_' OR n.name LIKE '_o%ma_')
  AND n.gender = 'm'
  AND k.phonetic_code IS NOT NULL
  AND t.kind_id IN (7, 2, 1, 3)
ORDER BY t.production_year DESC
LIMIT 200;
