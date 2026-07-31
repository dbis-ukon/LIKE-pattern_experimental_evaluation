SELECT akat.movie_id, akat.title, MAX(akat.production_year) AS latest_year, COUNT(DISTINCT ci.person_id) AS main_cast
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
WHERE ci.nr_order <= 17
  AND akat.production_year BETWEEN 1986 AND 2013
  AND cn.name LIKE 'Wingnut'
  AND n.name LIKE '_i% Les%'
  AND rt.role = 'director'
  AND c.name LIKE '%as_ One'
  AND c.country_code = '[kz]'
  AND ct.kind = 'production companies'
  AND mi.note LIKE '%special%'
  AND it.info LIKE '%budget%'
  AND akat.title LIKE 'W_y Change Your %sband?'
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
