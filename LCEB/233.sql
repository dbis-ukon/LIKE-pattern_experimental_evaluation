SELECT akat.movie_id,
       t.title,
       cn.name AS character_name,
       ci.role_id,
       k.keyword AS movie_keyword,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       c.name AS company_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN title t ON akat.movie_id = t.id
WHERE akat.title LIKE '%er s%hl_arte _ä_st_'
  AND t.title LIKE '%E%'
  AND cn.name LIKE '%k_l_j_St_k_ov'
  AND n.name LIKE 'Sh% _aolun'
  AND k.keyword LIKE '1%h-_m%dm_nt'
  AND c.name LIKE 'Star R%z P_od_ctions Co.'
  AND akat.production_year >= 1955
GROUP BY akat.movie_id, t.title, cn.name, ci.role_id, k.keyword, c.name
ORDER BY main_cast DESC;
