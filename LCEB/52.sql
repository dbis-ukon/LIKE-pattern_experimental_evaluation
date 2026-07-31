SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MAX(akat.production_year) AS latest_year,
       MIN(ct.kind) AS company_type_kind,
       MIN(n.gender) AS gender_flag,
       MIN(c.country_code) AS country,
       MIN(comp.kind) AS comp_cast_kind
FROM aka_title akat
JOIN movie_keyword mk1 ON akat.movie_id = mk1.movie_id
JOIN keyword k ON mk1.keyword_id = k.id
JOIN movie_keyword mk2 ON akat.movie_id = mk2.movie_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN comp_cast_type comp ON ci.role_id = comp.id
WHERE (akat.title LIKE 'Se_za un attim_ d_ respiro' OR akat.title LIKE '_e_Had Thre_')
  AND k.keyword LIKE 'i_le%i%'
  AND k2.keyword LIKE 'hotel-_e_k-cler_'
  AND c.country_code = '[au]'
  AND ci.nr_order <= 6
  AND n.gender IN ('m', 'f')
  AND ct.kind IN ('special effects companies', 'miscellaneous companies', 'production companies', 'distributors')
  AND comp.kind LIKE '%lead%'
  AND akat.production_year BETWEEN 1976 AND 1992
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
