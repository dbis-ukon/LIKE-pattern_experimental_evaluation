SELECT t.id, t.kind_id
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE '%h%r%'
  AND t.title LIKE '%re_t%r%u%'
  AND n.name LIKE 'McDerm%'
  AND t.production_year >= 2008
  AND ci.nr_order <= 1;
