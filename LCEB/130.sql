SELECT co.name, COUNT(DISTINCT k.id) AS num_keywords
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE co.name LIKE 'Oce_ot Pr_ductio_s'
  AND k.keyword LIKE '_m%es_-o_-%s_r_a'
  AND t.production_year BETWEEN 1987 AND 2012
GROUP BY co.name
ORDER BY num_keywords DESC;
