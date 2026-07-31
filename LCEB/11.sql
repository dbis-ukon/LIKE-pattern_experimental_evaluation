SELECT t.id, t.title
FROM title t
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN movie_info_idx mix ON t.id = mix.movie_id
JOIN info_type it2 ON mix.info_type_id = it2.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE t.production_year >= 2006
  AND it.info = 'portrayed in'
  AND mi.info IS NOT NULL
  AND it2.info = 'alternate versions'
  AND mix.info <> '6.3'
  AND (k.keyword LIKE 'pete_sbur%ke_t_cky' OR k.keyword LIKE '%sc%e%f%-y%d-%')
  AND n.gender = 'm'
  AND ci.nr_order BETWEEN 2 AND 8
  AND LENGTH(t.title) > 5;
