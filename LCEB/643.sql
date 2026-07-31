SELECT t.id, t.imdb_index
FROM title t
WHERE t.title LIKE '_ive l_ ci%ma'
  AND t.production_year >= 2000
  AND t.kind_id = 7
  AND EXISTS (
      SELECT 1
      FROM movie_keyword mk
      JOIN keyword k ON mk.keyword_id = k.id
      JOIN cast_info ci ON mk.movie_id = ci.movie_id
      JOIN name n ON ci.person_id = n.id
      JOIN char_name cn ON ci.person_role_id = cn.id
      JOIN company_name co ON ci.person_id = co.id
      WHERE mk.movie_id = t.id
        AND k.keyword LIKE 'dis_p_ea%ng-pe%l_'
        AND n.name LIKE '%'
        AND cn.name LIKE 'BASA Guard 1'
        AND co.name LIKE 'T%d%i%'
  );
