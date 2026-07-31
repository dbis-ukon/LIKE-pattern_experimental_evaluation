SELECT n.name, COUNT(DISTINCT t.id) AS films, AVG(t.production_year) AS avg_year, COUNT(DISTINCT k.id) AS kw_count
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (k.keyword LIKE 'price-r_ggin_')
  AND k.keyword NOT LIKE '%t%a%er%'
  AND (n.name LIKE '_lobo_skay% _at%na' OR n.name LIKE '%a%z%')
  AND t.kind_id IN (7, 6, 1, 4)
  AND t.production_year BETWEEN 2008 AND 2010
  AND ci.nr_order <= 1
  AND n.gender = 'm'
GROUP BY n.name
HAVING COUNT(DISTINCT t.id) > 1 AND COUNT(DISTINCT k.id) >= 1
ORDER BY films DESC, avg_year;
