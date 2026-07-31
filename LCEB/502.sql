SELECT akat.id, akat.title, akat.production_year, akat.kind_id, akat.md5sum,
       mc.company_id, c.name AS company_name,
       k.keyword
FROM aka_title akat
JOIN movie_companies mc  ON akat.movie_id = mc.movie_id
JOIN company_name c      ON mc.company_id = c.id
JOIN movie_keyword mk    ON akat.movie_id = mk.movie_id
JOIN keyword k           ON mk.keyword_id = k.id
LEFT JOIN cast_info ci   ON akat.movie_id = ci.movie_id
WHERE akat.title LIKE 'Sh%l_ %n_w%'
  AND akat.title LIKE '%uat 6_'
  AND c.name LIKE 'Sareg_ma Films'
  AND c.name LIKE 'N_rrow P_th _roduc_ion_'
  AND mc.company_type_id = 1
  AND k.keyword LIKE 'paychic-b%'
  AND akat.production_year BETWEEN 1943 AND 1969
  AND akat.kind_id IN (1, 4, 2)
  AND ci.role_id IS NOT NULL;
