SELECT t.id, t.title
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.production_year >= 2008
  AND t.production_year IS NOT NULL
  AND ci.nr_order <= 8
  AND n.gender IN ('m', 'f')
  AND k.keyword NOT LIKE '%e_c_-_o%r%n%o_dan'
  AND k.phonetic_code IS NOT NULL;
