SELECT cn.name AS character_name, t.title, ci.role_id, MAX(t.production_year) AS latest_year
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE cn.name LIKE 'Nat_ai%sp_on'
  AND t.title LIKE 'Jump'
  AND k.keyword LIKE '%b_y_-s_lit%g'
  AND c.name LIKE '% %d% P%'
  AND rt.role LIKE '%Main%'
  AND t.production_year >= 1996
GROUP BY cn.name, t.title, ci.role_id
ORDER BY latest_year DESC;
