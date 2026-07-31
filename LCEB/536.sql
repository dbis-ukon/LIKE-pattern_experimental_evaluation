SELECT
    akat.movie_id,
    COUNT(DISTINCT ci.person_id) AS main_cast,
    COUNT(DISTINCT mc.company_id) AS company_count,
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
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN info_type it           ON mi.info_type_id = it.id
JOIN movie_info_idx mix     ON t.id = mix.movie_id
JOIN info_type it2          ON mix.info_type_id = it2.id
WHERE akat.title LIKE '_u_ses_D_n''t%e_l'
  AND t.title LIKE '_a% le%m%'
  AND k.keyword LIKE 'co%a_in-ti%'
  AND c.name LIKE '%de_m%Pr%c%'
  AND n.name LIKE 'Bue_nel'
  AND cn.name LIKE '_l_a Ma_'
  AND t.production_year >= 2007
  AND ci.nr_order BETWEEN 1 AND 8
GROUP BY akat.movie_id
ORDER BY main_cast DESC;
