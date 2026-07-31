SELECT t.id, t.production_year
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
WHERE k.keyword LIKE 'm_l_-p_t-in-a-_leepe_'
  AND t.title LIKE '%9%-%-_8)'
  AND t.production_year >= 2012
  AND ci.role_id = 1;
