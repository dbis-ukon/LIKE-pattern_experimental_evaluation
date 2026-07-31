SELECT id, name, md5sum
FROM name n
WHERE n.name LIKE '%i%C%to_'
  AND (n.name_pcode_nf = 'P4563' OR n.surname_pcode = 'P62')
  AND n.imdb_id IS NOT NULL;
