SELECT t.id, t.title,
       COUNT(DISTINCT k.id) AS keyword_count,
       COUNT(DISTINCT ci.person_id) AS cast_count,
       COUNT(DISTINCT mc.company_id) AS company_count
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
WHERE t.title LIKE 'Y_kusoku'           -- non-selective
  AND akat.title LIKE '%i_e %'         -- moderately selective
  AND k.keyword LIKE '%ee%repai_'      -- highly selective
  AND n.name LIKE 'Tip%P_r_c_ai'          -- moderately selective
  AND cn.name LIKE '% %ou_ce_ o_ _er%i%'       -- highly selective
  AND c.name LIKE '_av_d%aw%nc_ %o%t%n_'       -- non-selective
  AND t.production_year BETWEEN 1993 AND 2005
GROUP BY t.id, t.title
ORDER BY keyword_count DESC;
