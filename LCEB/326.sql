SELECT id, name, imdb_id, name_pcode_cf
FROM name n
WHERE n.name LIKE 'Bi_nert_ Pascal_'
  AND (n.gender = 'f' OR n.imdb_id < 10000);
