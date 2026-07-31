SELECT id, name, imdb_id, gender
FROM name n
WHERE (n.name LIKE 'Di_linger' OR n.name LIKE 'P%t% %')
  AND n.gender = 'm'
  AND n.imdb_id IS NOT NULL;
