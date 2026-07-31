SELECT
    n.name,
    COUNT(DISTINCT a.movie_id) AS total_movies
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN aka_title a ON a.movie_id = ci.movie_id
JOIN movie_companies mc ON mc.movie_id = a.movie_id
WHERE (n.name LIKE 'O''N_ill' OR n.name LIKE 'F_chigami')
  AND n.gender = 'f'
  AND mc.note NOT LIKE '%Documentary%'
  AND a.season_nr = 1
GROUP BY n.name
ORDER BY total_movies DESC;
