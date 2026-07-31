SELECT t.id, ci.person_role_id
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN aka_name akan ON ci.person_id = akan.person_id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN complete_cast cc ON t.id = cc.movie_id
JOIN movie_link ml ON t.id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE '%bby_horse'
  AND t.title LIKE '(%.35_'
  AND n.name LIKE 'Va_si_ia_s%te_e'
  AND ci.person_role_id > 4463
  AND t.production_year >= 1996
  AND ci.role_id = 2
  AND cc.status_id = 3
  AND ct.kind IN ('special effects companies', 'production companies', 'distributors', 'miscellaneous companies');
