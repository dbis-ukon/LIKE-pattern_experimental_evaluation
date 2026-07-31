SELECT
    t.id,
    t.title,
    COUNT(DISTINCT k.id) AS keywords,
    COUNT(DISTINCT ci.person_id) AS cast_size
FROM title t
JOIN aka_title akat           ON t.id = akat.movie_id
JOIN movie_keyword mk       ON t.id = mk.movie_id
JOIN keyword k              ON mk.keyword_id = k.id
JOIN cast_info ci           ON t.id = ci.movie_id
JOIN name n                 ON ci.person_id = n.id
JOIN role_type rt           ON ci.role_id = rt.id
JOIN char_name cn           ON ci.person_role_id = cn.id
JOIN movie_companies mc     ON t.id = mc.movie_id
JOIN company_name c         ON mc.company_id = c.id
WHERE t.title LIKE '_hicago _resents an Evening of Holiday Music a_d Greatest Hits'
  AND akat.title LIKE '%h%e%y'
  AND k.keyword LIKE '%e%t%utf%'
  AND c.name LIKE '_oh_ Abb% %odu%o%'
  AND n.name LIKE 'H_t_ab'
  AND cn.name LIKE '%M%c_'
  AND t.production_year BETWEEN 1961 AND 2000
  AND ci.nr_order <= 24
GROUP BY t.id, t.title
ORDER BY keywords DESC;
