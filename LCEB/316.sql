SELECT id, name, gender, imdb_index
FROM name n
WHERE (n.name LIKE 'Mu%' OR n.name LIKE 'M%w_')
  AND n.surname_pcode = 'K5';
