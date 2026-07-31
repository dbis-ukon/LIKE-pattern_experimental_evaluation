SELECT akat.movie_id, akat.title, MAX(akat.production_year) AS latest_year, COUNT(DISTINCT ci.person_id) AS main_cast
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
WHERE ci.nr_order <= 5
  AND akat.production_year BETWEEN 2000 AND 2011
  AND cn.name LIKE 'E_i_abet_ N_y'
  AND n.name LIKE '%v%r_'
  AND rt.role IN ('actress', 'composer', 'miscellaneous crew', 'director', 'editor')
  AND k.keyword LIKE 'snipe-hunt'
  AND c.name LIKE 'Pan _erra'
  AND ct.kind = 'special effects companies'
  AND mi.info LIKE '%rating%'
  AND mi.note LIKE '%remastered%'
  AND it.info LIKE '%profit%'
  AND akat.season_nr BETWEEN 7 AND 13
  AND akat.episode_nr BETWEEN 3 AND 5
  AND akat.title LIKE 'Der_J% s_i_e%L_be% _'
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
