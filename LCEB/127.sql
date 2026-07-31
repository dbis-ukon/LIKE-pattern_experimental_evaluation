SELECT co.name, COUNT(DISTINCT n.id) AS linked_actors
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
JOIN complete_cast cc ON cc.movie_id = t.id
JOIN name n ON n.id = cc.subject_id
WHERE co.name LIKE 'Gos%noprom Gru_ii'
  AND t.episode_nr <= 10
  AND n.gender = 'm'
GROUP BY co.name
ORDER BY linked_actors DESC;
