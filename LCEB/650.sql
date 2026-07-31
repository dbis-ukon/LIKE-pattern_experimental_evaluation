SELECT n.name, COUNT(DISTINCT t.id) AS films, AVG(t.production_year) AS avg_year, COUNT(DISTINCT k.id) AS kw_count
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (n.name LIKE '%n_ S%h' OR n.name LIKE 'Henr% _mm_')
  AND t.production_year BETWEEN 2002 AND 2011
  AND t.season_nr IS NULL
  AND (k.keyword LIKE '%e_-%a%')
  AND k.keyword NOT LIKE 'priso_-_o_d%ang'
  AND ci.role_id IN (2, 4, 3, 10, 1)
  AND t.episode_nr <= 1
GROUP BY n.name
HAVING COUNT(DISTINCT t.id) > 5 AND COUNT(DISTINCT k.id) >= 1
ORDER BY films DESC, avg_year;
