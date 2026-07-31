SELECT akat.title,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       COUNT(DISTINCT k.id) AS keyword_count,
       MAX(t.production_year) AS latest_year
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE akat.title LIKE '% %d %l%'          -- moderately selective
  AND t.title LIKE '_20%14_'             -- moderately selective
  AND k.keyword LIKE '_in_er_f_r-%'         -- highly selective
  AND n.name LIKE '%x_o%'            -- moderately selective
  AND cn.name LIKE '_kin_y kid'          -- highly selective
  AND c.name LIKE 'Klaus Knoesel_F_l_produktion'     -- low selective
  AND t.production_year >= 2001
GROUP BY akat.title
ORDER BY main_cast DESC;
