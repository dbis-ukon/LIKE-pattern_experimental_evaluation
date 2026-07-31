SELECT *
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'Os_ _9'
  AND cn.name LIKE '_iu Junq_'
  AND k.keyword LIKE 'slur_ee'
  AND ci.role_id = 1
  AND t.production_year >= 1964
  AND t.series_years IS NOT NULL
  AND t.kind_id = 7
  AND ci.person_role_id = 330494;
