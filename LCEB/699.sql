SELECT name, production_year, n_titles,
       SUM(n_titles) OVER (PARTITION BY name ORDER BY production_year) AS cumulative_titles
FROM (
  SELECT cn.name, t.production_year, COUNT(DISTINCT t.id) AS n_titles
  FROM company_name cn
  JOIN movie_companies mc ON cn.id = mc.company_id
  JOIN title t ON mc.movie_id = t.id
  JOIN movie_keyword mk ON t.id = mk.movie_id
  JOIN keyword k ON mk.keyword_id = k.id
  JOIN aka_title akat ON t.id = akat.movie_id
  WHERE (cn.name LIKE '%l%D%n_ %m_ L%'
      OR cn.name LIKE '%psfilm'
      OR cn.name LIKE 'Shanda Pictures'
      OR cn.name LIKE 'P_blic_Uni%it%f Navarr_'
      OR cn.name LIKE 'G%R_d_ %in_')
    AND t.title NOT LIKE 'La horde'
    AND k.keyword LIKE 's%a%a'
    AND akat.title LIKE 'Ma% e T%'
    AND cn.country_code = '[jp]'
    AND mc.company_type_id IN (1, 2)
    AND mc.note IS NULL
    AND t.kind_id IN (7, 3, 1)
    AND t.production_year IS NOT NULL
    AND akat.md5sum IS NOT NULL
  GROUP BY cn.name, t.production_year
) yr
ORDER BY name, production_year;
