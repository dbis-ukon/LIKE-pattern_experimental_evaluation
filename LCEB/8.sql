SELECT t.id, t.title
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN name n ON ci.person_id = n.id
JOIN aka_name akan ON n.id = akan.person_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE kt.kind IN ('tv movie', 'episode', 'video game', 'video movie', 'tv mini series')
  AND rt.role <> 'producer'
  AND t.production_year BETWEEN 1965 AND 1981
  AND t.series_years IS NOT NULL
  AND (n.gender = 'm' OR n.gender IS NULL)
  AND akan.name LIKE '%son'
  AND (k.keyword LIKE 'referen%-_o-th_-_arr_ck%a_tie_' OR k.keyword LIKE '%a_ty')
  AND it.info = 'studios'
  AND mi.info NOT IN ('Horror','Documentary')
  AND c.country_code IN ('[ie]', '[de]', '[fi]', '[hu]', '[mx]')
  AND ct.kind = 'production companies'
  AND ci.nr_order <= 0
  AND LENGTH(akan.name) > 4
GROUP BY t.id, t.title
HAVING COUNT(DISTINCT ci.person_id) >= 2
ORDER BY t.production_year DESC;
