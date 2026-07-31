SELECT t.id, t.title
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE 'p%ose_es%i_logue'
)
  AND cn.name LIKE '_entle_an T%e_'
  AND ci.nr_order <= 28
  AND t.production_year >= 1977;
