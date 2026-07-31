SELECT t.id, n.imdb_index
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE (k.keyword LIKE '_l_m_ic-%e_-%' OR k.keyword LIKE '%w%lth')
  AND t.title LIKE 'Pitbull'
  AND n.name LIKE '_l%r%Ma_uxa'
  AND n.imdb_index IS NOT NULL
  AND ci.nr_order <= 1
  AND t.kind_id = 7;
