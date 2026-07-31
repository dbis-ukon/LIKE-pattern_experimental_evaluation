SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MAX(akat.production_year) AS latest_year,
       MIN(ct.kind) AS company_type_kind,
       MIN(comp.kind) AS comp_cast_kind,
       MIN(n.gender) AS gender_flag
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN comp_cast_type comp ON ci.role_id = comp.id
WHERE (akat.title LIKE 'Pr_l_t_l_ sov_' OR akat.title LIKE '_u%e %')
  AND k.keyword LIKE 'eps_m-derby'
  AND c.country_code = '[us]'
  AND ci.nr_order <= 2
  AND n.gender IN ('f', 'm')
  AND ct.kind IN ('production companies', 'special effects companies', 'distributors', 'miscellaneous companies')
  AND akat.production_year BETWEEN 1947 AND 2001
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
