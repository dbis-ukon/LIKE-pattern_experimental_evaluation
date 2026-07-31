SELECT cn.name, COUNT(DISTINCT ci.movie_id) AS movie_count, COUNT(DISTINCT k.id) AS num_keywords, MAX(t.production_year) AS last_year
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE (cn.name LIKE 'Op%at_r of Cali_an' OR cn.name LIKE 'Col_tte Le_e_ci_r')
  AND co.country_code = '[us]'
  AND t.production_year BETWEEN 2006 AND 2010
  AND (ci.nr_order <= 1 OR t.season_nr = 1)
GROUP BY cn.name
ORDER BY last_year DESC;
