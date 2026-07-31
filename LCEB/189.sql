SELECT
    n.name,
    COUNT(DISTINCT a.movie_id) AS total_movies,
    AVG(a.production_year) AS avg_year
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN aka_title a ON a.movie_id = ci.movie_id
WHERE n.name LIKE 'S_ve'
  AND n.gender = 'm'
  AND a.season_nr >= 1
  AND ci.nr_order <= 5
GROUP BY n.name
ORDER BY total_movies DESC;
