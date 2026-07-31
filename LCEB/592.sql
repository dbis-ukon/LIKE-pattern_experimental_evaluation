SELECT t.id, t.imdb_index
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE 'c_d_-%ea%g'
  AND t.title LIKE 'Idiodyssey'
  AND n.name LIKE 'Kea%s%ifto_'
  AND t.production_year >= 2006
  AND ci.role_id = 1;
