SELECT akat.title,
       cn.name AS character_name,
       rt.role,
       akat.production_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE (akat.title LIKE '%r%e_23' OR akat.title LIKE '_he %pr%T%r_')
  AND (cn.name LIKE 'Lord Dover%use' OR cn.name LIKE 'D_ G_rret_')
  AND akat.production_year BETWEEN 1993 AND 2002
  AND ci.nr_order BETWEEN 3 AND 8
  AND akat.season_nr = 7
  AND cn.name_pcode_nf IS NOT NULL
ORDER BY akat.production_year DESC;
