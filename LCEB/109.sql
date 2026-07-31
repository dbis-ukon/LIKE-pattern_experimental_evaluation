SELECT cn.name, COUNT(DISTINCT n.id) AS linked_actors
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN complete_cast cc ON cc.movie_id = ci.movie_id
JOIN name n ON n.id = cc.subject_id
WHERE cn.name LIKE '_i%s älte%r%'
  AND n.gender = 'm'
  AND (cc.status_id IS NOT NULL OR n.imdb_id IS NOT NULL)
GROUP BY cn.name
ORDER BY linked_actors DESC;
