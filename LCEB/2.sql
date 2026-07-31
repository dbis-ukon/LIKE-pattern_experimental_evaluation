SELECT t.id, t.title, cn.name AS character_name
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '%o% B%g'
  AND cn.name LIKE '_liv_e%Bé_aille'
  AND k.keyword LIKE 'k_l%''%tr_p_y'
  AND ci.role_id = 10
  AND t.production_year >= 2007;
