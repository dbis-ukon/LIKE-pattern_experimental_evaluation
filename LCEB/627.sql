SELECT t.id, n.name, cn.name
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE 'general-dynamics-f-16-fighting-falcon'
)
  AND n.name LIKE '_o%e_o%d%'
  AND cn.name LIKE 'Seu M_laq_ias'
  AND ci.nr_order <= 1
  AND t.production_year BETWEEN 1999 AND 2011;
