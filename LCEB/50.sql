SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MAX(akat.production_year) AS latest_year,
       MIN(mc.id) AS first_company_id,
       MIN(ct.kind) AS company_type_kind,
       MIN(n.gender) AS gender_flag
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
WHERE (akat.title LIKE 'Be%een Sh_r%' OR akat.title LIKE '_om_n''s Ri_hts')
  AND k.keyword LIKE 'british-drinking-song'
  AND c.country_code = '[nz]'
  AND n.gender = 'm'
  AND ci.nr_order <= 3
  AND rt.role IN ('actress', 'writer', 'costume designer', 'editor', 'composer')
  AND cn.name LIKE '%n%o%o_'
  AND akat.production_year BETWEEN 1967 AND 1987
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
