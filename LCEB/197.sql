SELECT
    n.name,
    COUNT(DISTINCT k.id) AS keyword_count,
    AVG(a.production_year) AS avg_year
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN aka_title a ON a.movie_id = ci.movie_id
JOIN movie_keyword mk ON mk.movie_id = a.movie_id
JOIN keyword k ON k.id = mk.keyword_id
WHERE n.name LIKE 'Kray_ek'
  AND k.keyword LIKE '_azi-_ccupied-gre_c_'
  AND a.season_nr = 3
  AND ci.nr_order <= 14
GROUP BY n.name
ORDER BY keyword_count DESC;
