SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MAX(akat.production_year) AS latest_year,
       MIN(mc.id) AS first_company_id,
       MIN(ct.kind) AS company_type_kind,
       MIN(c.country_code) AS country,
       MIN(n.gender) AS gender_flag
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
JOIN role_type rt ON ci.role_id = rt.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
WHERE (akat.title LIKE '_a_i% % %e%di_Fuz%' OR akat.title LIKE '%ung_Wisely II')
  AND k.keyword LIKE '_i_la_d%-hym_'
  AND k2.keyword LIKE 'ref%e%t_-%-%h%'
  AND c.country_code = '[mx]'
  AND ci.nr_order <= 1
  AND rt.role IN ('miscellaneous crew', 'director', 'actress', 'producer', 'guest')
  AND n.gender = 'f'
  AND cn.name LIKE '_i_pi%'
  AND mi.info LIKE '%budget%'
  AND it.info LIKE '%profit%'
  AND akat.episode_nr BETWEEN 1 AND 18
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
