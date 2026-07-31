SELECT a.title, n.name AS actor_name, cn.name AS char_name, k.keyword
FROM aka_title a
LEFT JOIN cast_info ci ON a.movie_id = ci.movie_id
LEFT JOIN name n ON ci.person_id = n.id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
LEFT JOIN movie_keyword mk ON a.movie_id = mk.movie_id
LEFT JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE '%gh%FM'
  AND n.name LIKE 'Richardson'
  AND cn.name LIKE '%ise'
  AND k.keyword LIKE 'fi%room'
  AND a.production_year BETWEEN 1982 AND 1988;
