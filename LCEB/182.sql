SELECT
    n.name AS actor_name,
    COUNT(DISTINCT t.id) AS movie_count,
    MAX(t.production_year) AS latest_year
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.gender = 'f'
  AND k.keyword LIKE 'chemistry-student'
  AND t.production_year >= 1971
GROUP BY n.name
ORDER BY movie_count DESC;
