SELECT
    t.title,
    c.name AS villain_name,
    co.name AS company_name,
    SUM(t.episode_nr) AS total_episodes,
    MAX(t.production_year) AS latest_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name c ON ci.person_role_id = c.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE c.name LIKE '_e%a%n_e_'
  AND co.name LIKE '_lickerfest Short Film Bureau'
  AND t.season_nr >= 3
  AND t.episode_nr > 5
GROUP BY t.title, c.name, co.name
ORDER BY total_episodes DESC;
