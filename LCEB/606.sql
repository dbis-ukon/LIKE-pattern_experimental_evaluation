SELECT t.id, t.title
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
WHERE t.production_year >= 2010
  AND EXISTS (
      SELECT 1
      FROM movie_keyword mk
      JOIN keyword k ON mk.keyword_id = k.id
      WHERE mk.movie_id = t.id
        AND k.keyword LIKE 'reference-t%._po%o_head'
  )
  AND akat.title LIKE 'Cri%na_i %t_o %o'
  AND t.kind_id = 7;
