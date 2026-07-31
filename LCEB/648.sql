SELECT n.name, COUNT(DISTINCT t.id) AS films, AVG(t.production_year) AS avg_year, COUNT(DISTINCT k.id) AS kw_count
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (n.name LIKE 'Zanuso' OR n.name LIKE '%c%')
  AND t.kind_id = 7
  AND t.episode_nr <= 47
  AND ci.nr_order <= 7
  AND n.gender = 'f'
  AND k.keyword LIKE '%o%-_h%'
GROUP BY n.name
HAVING COUNT(DISTINCT t.id) > 3 AND COUNT(DISTINCT k.id) >= 1
ORDER BY films DESC, avg_year;
