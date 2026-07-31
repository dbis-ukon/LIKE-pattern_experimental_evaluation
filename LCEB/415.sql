SELECT t.id, t.title, COUNT(DISTINCT ci.person_id) AS cast_count, MAX(t.production_year) AS latest_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'Ni% w_e%e_'
  AND cn.name LIKE 'Udo ''Bellucci'' G_abowski'
  AND rt.role LIKE '%Supporting%'
  AND k.keyword LIKE 'c_i_e-_f-passion'
  AND t.production_year >= 1993
  AND ci.nr_order BETWEEN 4 AND 8
GROUP BY t.id, t.title
ORDER BY cast_count DESC;
