SELECT k.id, k.keyword, k.phonetic_code
FROM keyword k
JOIN movie_keyword mk ON k.id = mk.keyword_id
JOIN title t ON mk.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN movie_companies mc ON t.id = mc.movie_id
WHERE (k.keyword LIKE 'to%-%e' OR k.keyword LIKE 'touri_t%u%in_')
  AND k.id BETWEEN 30186 AND 47165
  AND k.phonetic_code LIKE 'M%'
  AND t.production_year >= 2013
  AND ci.nr_order <= 1
  AND it.info LIKE '%award%'
  AND mc.company_type_id IN (2, 1);
