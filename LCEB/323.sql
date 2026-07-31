SELECT id, name, imdb_index, md5sum
FROM name n
WHERE (n.name LIKE 'Rang_l' OR n.name LIKE 'Niewiadomski')
  AND n.name LIKE 'Na%s_i%'
  AND (n.surname_pcode = 'B42' OR n.gender = 'm');
