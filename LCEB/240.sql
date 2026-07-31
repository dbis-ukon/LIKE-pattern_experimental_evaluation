SELECT cn.name AS character_name,
       ci.role_id,
       c.name AS company_name,
       COUNT(DISTINCT akat.movie_id) AS movie_count
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE 'Co_p_ra%d%ve_'
  AND n.name LIKE 'B_n_s%t%'
  AND akat.title LIKE '_heckpo_nt'
  AND t.title LIKE '_i%g %an_'
  AND c.name LIKE '%fi_l Im_a_'
  AND akat.production_year >= 1938
GROUP BY cn.name, ci.role_id, c.name
ORDER BY movie_count DESC;
