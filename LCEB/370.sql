SELECT k.id, k.keyword, k.phonetic_code
FROM keyword k
JOIN movie_keyword mk ON k.id = mk.keyword_id
JOIN title t ON mk.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE k.keyword LIKE '%lo%l_ie_'
  AND k.phonetic_code LIKE 'S%'
  AND k.id > 30186
  AND t.production_year BETWEEN 1913 AND 1971
  AND ci.nr_order <= 7
  AND n.gender = 'm'
  AND ct.kind IN ('miscellaneous companies', 'production companies', 'distributors', 'special effects companies');
