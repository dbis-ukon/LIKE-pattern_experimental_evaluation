SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keyword_count,
    AVG(t.production_year) AS avg_year,
    COUNT(DISTINCT ci.person_id) AS cast_count
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE '(_980-05-0_)'
  AND akat.title LIKE '%k %d%'
  AND k.keyword LIKE '%g-_au%t%k_ll_d'
  AND c.name LIKE 'Fr_m_ % P_o%c_i_n'
  AND n.name LIKE '_ndre_ C_ri_t%er'
  AND cn.name LIKE '%e_M_rdere_ Wa%hm_n'
  AND t.kind_id IN (7, 3, 1)
  AND t.production_year BETWEEN 1993 AND 2008
  AND ci.nr_order <= 22
GROUP BY t.id, t.title
ORDER BY keyword_count DESC;
