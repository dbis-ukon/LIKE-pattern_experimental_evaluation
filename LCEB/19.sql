SELECT t.id, t.title, akat.title AS aka, n.name, k.keyword
FROM title t
LEFT JOIN aka_title akat ON t.id = akat.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'Asim V_kshi'
  AND akat.title LIKE 'Mi%y und %uto fe_ern_W_ihn_cht_n'
  AND n.name LIKE '_h%ry'
  AND k.keyword LIKE 'scurvy'
  AND ci.role_id = 3
  AND ci.nr_order <= 5
  AND t.season_nr >= 5;
