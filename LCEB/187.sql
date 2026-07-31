SELECT
    n.name AS actor_name,
    t.title AS movie_title,
    t.season_nr,
    t.episode_nr,
    COUNT(DISTINCT ci.movie_id) AS appearance_count
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
WHERE (t.title LIKE '(_0_2-01-%)' OR t.title LIKE '%g%r%e_ bout%s')
  AND t.season_nr >= 5
  AND t.episode_nr > 20
  AND n.gender = 'm'
GROUP BY n.name, t.title, t.season_nr, t.episode_nr
ORDER BY appearance_count DESC;
