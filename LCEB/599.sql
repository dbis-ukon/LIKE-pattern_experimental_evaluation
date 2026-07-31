SELECT t.id, ci.person_role_id
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON c.id = ct.id
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN complete_cast cc ON t.id = cc.movie_id
WHERE k.keyword LIKE 'w%hing-bloo_-_ff-_n%s-_ace'
  AND t.title LIKE 'Eres un desalmado'
  AND n.name LIKE 'Li_d%'
  AND ci.person_role_id > 125499
  AND t.production_year >= 1926
  AND ci.role_id = 1
  AND cc.status_id = 3
  AND ct.kind IN ('special effects companies', 'production companies', 'distributors', 'miscellaneous companies');
