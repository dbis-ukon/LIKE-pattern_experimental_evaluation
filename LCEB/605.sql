SELECT t.id, t.episode_nr
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
LEFT JOIN aka_name akan ON ci.person_id = akan.person_id
LEFT JOIN movie_companies mc ON t.id = mc.movie_id
LEFT JOIN company_name c ON mc.company_id = c.id
LEFT JOIN company_type ct ON mc.company_type_id = ct.id
LEFT JOIN movie_info mi ON t.id = mi.movie_id
LEFT JOIN info_type it ON mi.info_type_id = it.id
LEFT JOIN complete_cast cc ON t.id = cc.movie_id
WHERE k.keyword LIKE '_oli%rno%'
  AND t.title LIKE '(_004-_0-27_'
  AND n.name LIKE 'L_e%e_te'
  AND t.episode_nr >= 11
  AND t.season_nr >= 1
  AND n.gender = 'm'
  AND ci.role_id = 4
  AND (akan.name IS NULL OR akan.name LIKE '%Laura%')
  AND (ct.kind IS NULL OR ct.kind IN ('special effects companies', 'production companies', 'miscellaneous companies', 'distributors'))
  AND (it.info IS NULL OR it.info LIKE '%award%')
  AND (cc.status_id IS NULL OR cc.status_id = 3);
