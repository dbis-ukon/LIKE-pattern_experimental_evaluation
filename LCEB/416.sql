SELECT cn.name AS character_name, COUNT(DISTINCT t.id) AS movie_count, MAX(t.production_year) AS latest_year
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN kind_type kt ON t.kind_id = kt.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE '_m_._B%'
  AND t.title LIKE '_om_u_s_ry _x_rcises'
  AND kt.kind LIKE '%Movie%'
  AND k.keyword LIKE '%l%o_ce_'
  AND t.production_year BETWEEN 1996 AND 2006
  AND ci.role_id IS NOT NULL
GROUP BY cn.name
ORDER BY movie_count DESC;
