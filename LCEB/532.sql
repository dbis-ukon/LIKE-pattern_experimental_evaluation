SELECT
    akat.movie_id,
    COUNT(DISTINCT ci.person_id) AS main_cast,
    MAX(t.production_year) AS latest_year
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE akat.title LIKE 'The Earth'
  AND t.title LIKE 'Cha_g_ng_Cook_'
  AND k.keyword LIKE '%fer%c%-%ai_'
  AND c.name LIKE 'P_odu_ción Indepe_diente'
  AND n.name LIKE 'Giller'
  AND cn.name LIKE '_r%r_'
  AND t.production_year > 2011
  AND mc.company_type_id = 1
GROUP BY akat.movie_id
ORDER BY main_cast DESC;
