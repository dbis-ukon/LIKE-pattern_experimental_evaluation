SELECT id, name, imdb_id, md5sum
FROM name n
WHERE (n.name LIKE 'Mitchel' OR n.name LIKE '_ev%ç%D%')
  AND n.name LIKE 'Bastová'
  AND (n.gender = 'f' OR n.imdb_id > 1000);
