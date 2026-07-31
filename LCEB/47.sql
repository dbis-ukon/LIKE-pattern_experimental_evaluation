SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MIN(akat.production_year) AS first_year,
       MAX(akat.production_year) AS latest_year,
       MIN(n.gender) AS gender_flag,
       MIN(ct.kind) AS company_type_kind,
       MIN(c.country_code) AS country,
       MAX(rt.role) AS max_role
FROM aka_title akat
JOIN movie_keyword mk1 ON akat.movie_id = mk1.movie_id
JOIN keyword k ON mk1.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
WHERE (akat.title LIKE '%s e_n_am_ %ni_' OR akat.title LIKE '_i_ Aben%e%e_nes O_t%e_kinde_')
  AND (k.keyword LIKE '_o%-%a%' OR k.keyword LIKE '%eta%ac%t%l%')
  AND c.country_code = '[dk]'
  AND n.gender = 'f'
  AND ci.nr_order <= 8
  AND rt.role = 'producer'
  AND mi.info LIKE '%box office%'
  AND it.info LIKE '%profit%'
  AND akat.episode_nr BETWEEN 1 AND 2
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
