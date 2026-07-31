SELECT t.id, t.title
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE 'steel-pl%t'
)
  AND n.name LIKE '%igh_on-%a_k_ P%ill_'
  AND ci.role_id = 1
  AND t.production_year >= 2002;
