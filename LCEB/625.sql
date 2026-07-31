SELECT t.id, t.title, n.gender
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE '_ic_or_-%rty'
)
  AND cn.name LIKE '_ynn_l_t'
  AND n.name LIKE 'Williams'
  AND t.production_year >= 1986
  AND ci.role_id = 1;
