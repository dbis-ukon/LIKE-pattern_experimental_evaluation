SELECT t.id, t.title
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE t.production_year >= 1910
  AND EXISTS (
      SELECT 1
      FROM movie_keyword mk
      JOIN keyword k ON mk.keyword_id = k.id
      WHERE mk.movie_id = t.id AND k.keyword LIKE '%e%ric_l-music'
  )
  AND akat.title LIKE 'Twenty Four'
  AND n.name LIKE 'M%ta_ Cam_la'
  AND ci.nr_order <= 8
  AND t.kind_id = 7;
