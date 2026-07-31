SELECT t.id, t.title,
       COUNT(DISTINCT ci.person_id) AS cast_count,
       COUNT(DISTINCT mc.company_id) AS company_count,
       MAX(t.production_year) AS latest_year
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE 'Teil 1'       -- moderately selective
  AND akat.title LIKE '_a % %n%i%'         -- highly selective (prefix)
  AND k.keyword LIKE 'pi%e%n_'    -- highly selective
  AND n.name LIKE 'N_eller'       -- moderately selective
  AND cn.name LIKE 'Sh_w%a_'    -- highly selective
  AND c.name LIKE 'A_ht_n View_Pr_moti_n_'         -- low selective
  AND t.production_year BETWEEN 1977 AND 2009
GROUP BY t.id, t.title
ORDER BY cast_count DESC;
