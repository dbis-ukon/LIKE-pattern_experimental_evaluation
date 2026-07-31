SELECT
    akat.movie_id,
    COUNT(DISTINCT cn.name) AS villain_roles
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN name n ON ci.person_id = n.id
WHERE (akat.title LIKE '%V%ries' OR akat.title LIKE 'Ca_i_o_nia Hig_s_h_ol _ _a%en%reß%d _r_t_ Liebe')
  AND cn.name LIKE 'Himself - Senior Treasury Official'
  AND rt.role LIKE '%actor%'
  AND n.name LIKE 'Rich_rdson'
  AND akat.production_year BETWEEN 1945 AND 1975
GROUP BY akat.movie_id
HAVING COUNT(DISTINCT cn.name) >= 2;
