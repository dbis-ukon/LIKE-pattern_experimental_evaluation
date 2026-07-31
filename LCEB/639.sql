SELECT t.id, rt.role, ci.nr_order
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE 'm%di%y'
)
  AND rt.role = 'writer'
  AND ci.nr_order <= 18
  AND t.production_year >= 1971;
