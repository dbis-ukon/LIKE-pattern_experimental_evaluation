SELECT t.id, t.title
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE '_ear_hin_-%-_ff_ce'
)
  AND n.name LIKE '%as%y_'
  AND cn.name LIKE 'Naomi_Blumenth_l'
  AND ci.nr_order <= 7
  AND t.production_year BETWEEN 2007 AND 2012;
