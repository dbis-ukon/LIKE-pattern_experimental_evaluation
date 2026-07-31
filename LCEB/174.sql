SELECT a.title, AVG(a.episode_nr) AS avg_episodes, COUNT(DISTINCT k.id) AS num_keywords
FROM aka_title a
JOIN movie_keyword mk ON mk.movie_id = a.movie_id
JOIN keyword k ON k.id = mk.keyword_id
WHERE a.title LIKE 'Love%v_r_ast%'
  AND k.keyword LIKE 'obese-person'
  AND a.season_nr BETWEEN 1 AND 2
GROUP BY a.title
ORDER BY avg_episodes DESC;
