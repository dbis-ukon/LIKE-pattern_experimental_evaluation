SELECT akat.movie_id, akat.title, MAX(akat.production_year) AS latest_year, COUNT(DISTINCT ci.person_id) AS main_cast
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
WHERE ci.nr_order <= 12
  AND akat.production_year BETWEEN 2001 AND 2012
  AND n.name LIKE '_ove_ He_t_er'
  AND rt.role = 'miscellaneous crew'
  AND k.keyword LIKE '%oad_a%si%l'
  AND lt.link LIKE '%sequel%'
  AND akat.season_nr >= 1
  AND akat.episode_nr <= 1
  AND c.name LIKE '_ist% %d_ct_o_s'
  AND c.country_code = '[ca]'
  AND mi.info LIKE '%box office%'
  AND it.info LIKE '%revenue%'
  AND akat.title LIKE '_r_. _o_es_ L_v%'
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
