SELECT t.id, t.title
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE '%ella-i%oo%'
)
  AND n.name LIKE '%p%._T%'
  AND cn.name LIKE '_ale _en_a_r'
  AND co.name LIKE '%eat_We%res'
  AND ci.nr_order <= 11
  AND t.production_year BETWEEN 1996 AND 2000;
