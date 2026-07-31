SELECT
    n.name,
    MIN(a.production_year) AS first_movie,
    MAX(a.production_year) AS last_movie
FROM name n
JOIN complete_cast cc ON cc.subject_id = n.id
JOIN aka_title a ON a.movie_id = cc.movie_id
WHERE n.name LIKE '_a_s'
  AND n.gender = 'f'
  AND a.season_nr BETWEEN 2 AND 11
  AND a.episode_nr >= 8
GROUP BY n.name
ORDER BY last_movie DESC;
