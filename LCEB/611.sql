SELECT t.id, t.title
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE '%s%p'
)
  AND n.name LIKE 'Michel'
  AND rt.role = 'cinematographer'
  AND ci.nr_order <= 29
  AND t.production_year >= 2013;
