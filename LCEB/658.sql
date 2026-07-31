SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE k.keyword NOT LIKE '_azz%ri_'
  AND t.production_year < 2012
  AND n.gender = 'm'
  AND (t.title LIKE '%sch' OR n.name LIKE '%t%m')
  AND ci.nr_order IS NOT NULL
ORDER BY t.production_year DESC
LIMIT 200;
