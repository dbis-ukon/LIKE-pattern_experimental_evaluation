SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       c.name AS company_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE cn.name LIKE 'Sharon Newman #2'
  AND akat.title LIKE 'Saadan _kal de have det'
  AND n.name LIKE 'Mairs'
  AND c.name LIKE '_TM%EV P%u%'
  AND ci.nr_order <= 8
  AND akat.season_nr BETWEEN 1 AND 1
  AND akat.episode_nr IS NOT NULL
GROUP BY cn.name, ci.role_id, n.name, c.name
ORDER BY num_movies DESC;
