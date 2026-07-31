SELECT a.title, COUNT(DISTINCT cc.subject_id) AS total_actors
FROM aka_title a
JOIN complete_cast cc ON cc.movie_id = a.movie_id
JOIN name n ON n.id = cc.subject_id
WHERE a.title LIKE '%st_nf_c%k%e%n%ba%n'
  AND n.gender = 'f'
  AND a.episode_nr >= 1
GROUP BY a.title
ORDER BY total_actors DESC;
