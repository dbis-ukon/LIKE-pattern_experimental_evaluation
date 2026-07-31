SELECT id, name, imdb_index, surname_pcode
FROM name n
WHERE (n.name LIKE 'Betchadupa' OR n.name LIKE 'Joel_ Alexander' OR n.name LIKE 'G%t')
  AND n.gender = 'f';
