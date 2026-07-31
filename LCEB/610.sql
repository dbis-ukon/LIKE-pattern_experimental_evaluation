SELECT t.id, t.title
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
WHERE t.kind_id = 7
  AND EXISTS (
      SELECT 1
      FROM movie_companies mc
      JOIN company_name co ON mc.company_id = co.id
      WHERE mc.movie_id = t.id
        AND co.name LIKE '%P_i_r%'
  )
  AND akat.title LIKE 'Night Ambus_'
  AND t.production_year >= 1928;
