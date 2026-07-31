SELECT cn.name AS character_name, t.title, COUNT(DISTINCT k.keyword) AS keyword_count
FROM char_name cn
JOIN cast_info ci ON cn.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN kind_type kt ON t.kind_id = kt.id
WHERE cn.name LIKE 'Rhon% _rewer'
  AND t.title LIKE '(#1.20_)'
  AND k.keyword LIKE 'bad_singer'
  AND kt.kind LIKE '%TV%'
  AND ci.role_id IN (9, 10, 4, 2, 1)
GROUP BY cn.name, t.title
ORDER BY keyword_count DESC;
