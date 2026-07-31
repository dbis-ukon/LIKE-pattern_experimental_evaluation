SELECT t.id,
       t.title,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       COUNT(DISTINCT k.id) AS keyword_count,
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
JOIN movie_info mi          ON t.id = mi.movie_id
JOIN movie_info_idx mix     ON t.id = mix.movie_id
WHERE t.title LIKE '(1996-07-21)'         -- moderately selective
  AND akat.title LIKE 'T%P%'       -- moderately selective
  AND k.keyword LIKE '%cht'      -- highly selective
  AND n.name LIKE '_e'          -- moderately selective
  AND cn.name LIKE 'Za%stem% B%nc_'       -- highly selective
  AND c.name LIKE '_i_mw% %'       -- low selective
  AND t.production_year BETWEEN 1982 AND 2011
GROUP BY t.id, t.title
ORDER BY main_cast DESC;
