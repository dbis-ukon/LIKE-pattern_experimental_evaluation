SELECT
    t.id AS title_id,
    t.title AS main_title,
    at1.title AS aka_title1,
    at2.title AS aka_title2,
    n.name AS actor_name,
    k.keyword AS keyword_name
FROM title t
LEFT JOIN aka_title at1 ON t.id = at1.movie_id
LEFT JOIN aka_title at2 ON t.id = at2.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'Joy_e_Ca%l Oates'
  AND at1.title LIKE 'Moritz und Sein Doppelganger'
  AND at2.title LIKE 'Impossib% %urs'
  AND n.name LIKE '%s'
  AND k.keyword LIKE '%bbed-%-t%-_nk%'
  AND ci.role_id = 1
  AND ci.nr_order <= 1
  AND t.season_nr >= 2;
