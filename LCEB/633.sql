SELECT t.id, n.name, cn.name
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE 's%e-da%n'
)
  AND n.name LIKE 'Mc_lro_'
  AND cn.name LIKE 'J%y_W%'
  AND ci.role_id = 2
  AND t.production_year >= 1994;
