SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MAX(akat.production_year) AS latest_year,
       MIN(mc.id) AS first_company_id,
       MIN(ct.kind) AS company_type_kind,
       MIN(c.country_code) AS country
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
WHERE (akat.title LIKE 'I %lchi%a%a' OR akat.title LIKE 'U_for_ettable %n')
  AND (k.keyword LIKE '%at_u_-ho_r' OR k.keyword LIKE '_to_er-c_medy')
  AND c.country_code = '[gb]'
  AND n.gender = 'm'
  AND ci.nr_order <= 30
  AND rt.role IN ('miscellaneous crew', 'guest', 'cinematographer', 'actor', 'composer')
  AND mi.info LIKE '%budget%'
  AND it.info LIKE '%profit%'
  AND akat.episode_nr BETWEEN 5 AND 18
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
