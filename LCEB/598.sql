SELECT t.id, ci.person_role_id
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN complete_cast cc ON t.id = cc.movie_id
WHERE k.keyword LIKE '_ain_r_gh_'
  AND t.title LIKE '(1979-12-12_'
  AND n.name LIKE '%man%Willow Jea_e'
  AND ci.person_role_id > 2948770
  AND t.production_year >= 1911
  AND ci.role_id = 3
  AND cc.status_id = 4
  AND ct.kind IN ('production companies', 'special effects companies', 'miscellaneous companies', 'distributors');
