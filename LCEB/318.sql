SELECT id, name, md5sum
FROM name n
WHERE (n.name LIKE '_rt%' OR n.name LIKE 'Davis')
  AND (n.name_pcode_nf = 'E2535' OR n.gender = 'f');
