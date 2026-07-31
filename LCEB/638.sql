SELECT t.id, akat.title, ci.nr_order
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE 'group-leader'
)
  AND akat.title LIKE '_oco_- _e%u_i_rig_ Af_e'
  AND ci.nr_order <= 8
  AND t.production_year >= 1986;
