SELECT t.id, n.name, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE 'c_ber%tta_k'
)
  AND n.name LIKE 'L%d%ar_'
  AND rt.role = 'composer'
  AND ci.nr_order <= 17
  AND t.production_year >= 1986;
