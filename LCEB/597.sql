SELECT t.id, ci.person_role_id
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
-- additional joins
JOIN aka_name akan ON ci.person_id = akan.person_id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN complete_cast cc ON t.id = cc.movie_id
JOIN movie_link ml ON t.id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
WHERE (k.keyword LIKE '_oman-_vi_to_' OR k.keyword LIKE '%ual%-no%icatio_-team')
  AND t.title LIKE 'Le_so%1_'
  AND n.name LIKE '_h_n_ _or %ao'
  AND ci.person_role_id > 1089421
  AND t.production_year >= 2005
  AND ci.role_id = 4
  -- meaningful numeric / equality predicates from schema
  AND t.season_nr >= 1
  AND t.episode_nr >= 15
  AND mc.company_type_id IN (2, 1)  -- example production/distribution IDs
  AND cc.status_id = 3
  AND ci.nr_order <= 24
  AND t.kind_id IN (3, 1, 7)  -- example movie/kind types
  AND c.country_code = '[br]';
