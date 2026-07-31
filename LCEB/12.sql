SELECT DISTINCT t.id, t.title
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN name n ON ci.person_id = n.id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
LEFT JOIN movie_companies mc ON t.id = mc.movie_id
LEFT JOIN company_name c ON mc.company_id = c.id
LEFT JOIN company_type ct ON mc.company_type_id = ct.id
JOIN complete_cast cc ON t.id = cc.movie_id
WHERE t.production_year BETWEEN 2000 AND 2010
  AND t.series_years IS NOT NULL
  AND kt.kind = 'episode'
  AND rt.role = 'actress'
  AND (n.gender = 'm' OR n.gender IS NULL)
  AND (k.keyword LIKE 'quo' OR k.keyword LIKE 'slea_y')
  AND (cn.name LIKE '%t_n_ th_ %tl%' OR cn.name LIKE 'K_ns%n von_N_u_ath')
  AND (ct.kind = 'production companies' OR ct.kind IS NULL)
  AND t.title LIKE '(#17.75)'
GROUP BY t.id, t.title
HAVING COUNT(ci.id) > 2
ORDER BY t.id;
