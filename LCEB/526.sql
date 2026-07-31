SELECT
    akat.movie_id,
    MIN(t.production_year) AS first_year,
    COUNT(DISTINCT ci.person_id) AS cast_size
FROM aka_title akat
JOIN title t                ON akat.movie_id = t.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE akat.title LIKE '_o_m%C%r%a_'
  AND t.title LIKE '(_1.161)'
  AND k.keyword LIKE 'p_ra_oi%psych_si_'
  AND n.name LIKE 'Wan_'
  AND cn.name LIKE 'B_i_is%G_y 1'
  AND c.name LIKE '_is_n%Ne_wo_k'
GROUP BY akat.movie_id
ORDER BY first_year ASC;
