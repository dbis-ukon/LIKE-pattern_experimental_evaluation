SELECT t.id, t.title, n.name
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.gender = 'f'
  AND k.keyword NOT LIKE 'r_cism'
  AND t.title LIKE 'Doubl_ je_...';
