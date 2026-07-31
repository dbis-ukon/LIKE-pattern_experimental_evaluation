SELECT t.id, cn.name, n.gender
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN name n ON ci.person_id = n.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE '%lking-arou_d_n%e'
)
  AND cn.name LIKE '%ela'
  AND n.gender = 'm'
  AND ci.nr_order <= 3
  AND t.production_year >= 2011;
