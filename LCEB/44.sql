SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MAX(akat.production_year) AS latest_year,
       MIN(mc.id) AS first_company_id
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
WHERE (akat.title LIKE 'Ü_u_g_n%e_ %usch%t' OR akat.title LIKE 'The Mindbender')
  AND k.keyword LIKE '_acuum-cleanin_'
  AND ct.kind IN ('distributors', 'production companies', 'miscellaneous companies', 'special effects companies')
  AND (ci.nr_order <= 20 OR rt.role = 'producer')
  AND akat.episode_nr BETWEEN 28 AND 197
  AND akat.production_year BETWEEN 1941 AND 1973
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
