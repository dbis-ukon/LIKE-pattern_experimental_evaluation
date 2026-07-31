SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keyword_count,
    COUNT(DISTINCT ci.person_id) AS cast_count,
    MIN(t.production_year) AS first_year
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE '%p_ % %'
  AND akat.title LIKE 'S%mi_'
  AND k.keyword LIKE 'dr_ma%ad_-_o%ch%p_n_ee'
  AND n.name LIKE '%ll_z'
  AND cn.name LIKE 'Mar_h% della _argari_a'
  AND c.name LIKE 'B_yond G%s'
GROUP BY t.id, t.title
ORDER BY first_year ASC;
