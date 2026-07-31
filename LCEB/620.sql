SELECT t.id, t.title
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE '%6_-%t%oi_'
)
  AND akat.title LIKE '_a%a_L_ne f_r %W_l_'
  AND ci.nr_order <= 55
  AND t.production_year >= 2006;
