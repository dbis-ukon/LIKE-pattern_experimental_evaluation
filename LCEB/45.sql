SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MIN(akat.production_year) AS first_year,
       MAX(akat.production_year) AS latest_year,
       MIN(n.gender) AS gender_flag,
       MIN(ct.kind) AS company_type_kind
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE (akat.title LIKE '_in_m%ar%s_' OR akat.title LIKE 'Bra_ St%er% L_gend_o_ t_e M_mm_ 2')
  AND k.keyword LIKE '_eart-sha_ed-locket'
  AND (c.name LIKE '_a%el _. Oje%' OR c.country_code = '[in]')
  AND n.gender IN ('m', 'f')
  AND cn.name LIKE 'Ma%n Yount'
  AND akat.episode_nr BETWEEN 3 AND 4
  AND akat.production_year BETWEEN 2001 AND 2009
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
