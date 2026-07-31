SELECT t.id, t.title, n.name, cn.name AS character_name, k.keyword
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '_la_kl% C%l_n%'
  AND n.name LIKE 'Kempster'
  AND cn.name LIKE '_oung _te%a%e'
  AND k.keyword LIKE 'cigar-butt'
  AND ci.nr_order <= 20
  AND ci.role_id = 10
  AND t.episode_nr >= 11882;
