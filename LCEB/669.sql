SELECT t.title, k.keyword, t.production_year
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '_o_ds%ro_ t%Mist'
  AND k.phonetic_code IS NOT NULL
  AND t.episode_nr <= 62
  AND t.kind_id IN (1, 7)
  AND k.keyword LIKE 'an%ju%'
  AND t.production_year >= 1993
ORDER BY t.production_year DESC
LIMIT 100;
