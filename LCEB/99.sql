SELECT t.title, cn.name, n.name AS actor_name
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
WHERE t.title LIKE 'T%o_t%i%'
  AND cn.name LIKE 'P_lly Prim - Sten%rapher'
  AND n.name LIKE 'Gray'
  AND t.production_year > 2011
  AND ci.nr_order <= 1
  AND t.episode_nr <= 131;
