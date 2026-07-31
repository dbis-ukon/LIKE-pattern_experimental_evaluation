SELECT
    h.name AS hero_name,
    v.name AS villain_name,
    co.name AS company_name,
    k.keyword,
    COUNT(DISTINCT t.id) AS shared_movies
FROM cast_info ci_h
JOIN char_name h ON ci_h.person_role_id = h.id
JOIN cast_info ci_v ON ci_h.movie_id = ci_v.movie_id
JOIN char_name v ON ci_v.person_role_id = v.id
JOIN title t ON ci_h.movie_id = t.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE h.name LIKE 'O%a'
  AND v.name LIKE '%e_V%'
  AND co.name LIKE '%c_s_'
  AND k.keyword LIKE '_vil_m%c%'
  AND t.production_year >= 2006
GROUP BY h.name, v.name, co.name, k.keyword
ORDER BY shared_movies DESC;
