SELECT k.keyword, cn.name AS character_name, COUNT(DISTINCT t.id) AS movies
FROM keyword k
JOIN movie_keyword mk ON mk.keyword_id = k.id
JOIN title t ON t.id = mk.movie_id
JOIN cast_info ci ON ci.movie_id = t.id
JOIN char_name cn ON cn.id = ci.person_id
WHERE k.keyword LIKE '%in%p%'
  AND cn.name LIKE '%f_-%e%i_ %d%'
  AND ci.nr_order <= 5
  AND cn.imdb_id IS NOT NULL
GROUP BY k.keyword, cn.name
ORDER BY movies DESC;
