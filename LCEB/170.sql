SELECT a.title, COUNT(DISTINCT k.id) AS num_keywords, AVG(a.episode_nr) AS avg_episodes
FROM aka_title a
JOIN movie_keyword mk ON mk.movie_id = a.movie_id
JOIN keyword k ON k.id = mk.keyword_id
WHERE a.title LIKE 'T_e Heav_nly _odie_'
  AND k.keyword LIKE '%an_s_hatch'
  AND a.season_nr BETWEEN 1 AND 1
GROUP BY a.title
ORDER BY num_keywords DESC;
