SELECT DISTINCT t.title, akat.title AS alt_title, cn.name AS character_name
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN aka_title akat ON t.id = akat.movie_id
WHERE t.title LIKE 'Cum Buckets_ 3'
  AND cn.name LIKE '_o%n%st_r'
  AND akat.title LIKE '_e te_t%ent'
  AND ci.nr_order <= 3
  AND t.production_year BETWEEN 1986 AND 1995
  AND t.kind_id = 7;
