SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT n.id) AS num_actors
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE akat.title LIKE '_he S%d _u%Di_'
  AND k.keyword LIKE 'ki_nap_e_'
  AND n.name LIKE 'Schneemann%Gemma'
  AND n.gender = 'f'
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
