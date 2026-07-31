SELECT id, name, gender, imdb_index, imdb_id
FROM name n
WHERE (n.name LIKE 'Smooth_ Don' OR n.name LIKE '_a_ou_')
  AND n.gender = 'm'
  AND n.imdb_id > 1000;
