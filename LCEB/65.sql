SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       c.name AS company_name,
       k.keyword AS keyword
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE 'P%v%n_k'
  AND cn.name LIKE '%Fu%m%a_s _i_e'
  AND akat.title LIKE '%ve_and%re_De%n_'
  AND n.name LIKE 'Rhe_'
  AND k.keyword LIKE 'm_li_ar%so_'
  AND c.name LIKE 'Fábri_a de Cine'
  AND ct.kind IN ('special effects companies', 'production companies', 'distributors', 'miscellaneous companies')
  AND ci.nr_order IN (4, 17, 12, 18001, 6)
  AND akat.season_nr BETWEEN 1 AND 1
  AND akat.episode_nr >= 32
GROUP BY cn.name, ci.role_id, n.name, c.name, k.keyword
ORDER BY num_movies DESC;
