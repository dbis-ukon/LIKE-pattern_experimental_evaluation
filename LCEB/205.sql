SELECT
    n.name AS actor_name,
    COUNT(DISTINCT t.id) AS movie_count,
    SUM(t.season_nr) AS total_seasons,
    MAX(t.episode_nr) AS max_episode
FROM name n
JOIN complete_cast cc ON n.id = cc.subject_id
JOIN title t ON cc.movie_id = t.id
JOIN aka_title a ON t.id = a.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE 'McCaffer_y'
  AND a.title LIKE '_i_ _afia-%y'
  AND k.keyword LIKE '_urnt-h_ad'
  AND t.season_nr >= 2
GROUP BY n.name
ORDER BY movie_count DESC;
