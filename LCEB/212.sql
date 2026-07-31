SELECT cn.name AS character_name, MAX(akat.production_year) AS latest_year, rt.role AS role_type
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN title t ON akat.movie_id = t.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE (cn.name LIKE 'D%icu_' OR cn.name LIKE '%m%repl%e_t %ir_')
  AND (t.title LIKE '_hat _l_sted_Cu_ningham' OR t.title LIKE 'Secret_Service_Sec_ets')
  AND ci.role_id IS NOT NULL
GROUP BY cn.name, rt.role
ORDER BY latest_year DESC;
