SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MAX(akat.production_year) AS latest_year,
       MIN(ct.kind) AS company_type_kind,
       MIN(n.gender) AS gender_flag,
       MIN(c.country_code) AS country
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
WHERE (akat.title LIKE 'Hallowee%II_- _l_si_n_r%d%la%or_e' OR akat.title LIKE '_o%n%rt%by%')
  AND (k.keyword LIKE 'f_es%fr_nce' OR k.keyword LIKE '_emak_-_f-re_ake')
  AND c.country_code = '[be]'
  AND n.gender = 'm'
  AND ci.nr_order <= 14
  AND rt.role = 'director'
  AND cn.name LIKE 'M_rio_ Este_l_ _di_on'
  AND mi.info LIKE '%budget%'
  AND it.info LIKE '%profit%'
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
