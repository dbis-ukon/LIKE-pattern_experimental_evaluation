SELECT id, name, name_pcode_nf, gender
FROM name n
WHERE n.name LIKE 'Ev_ns'
  AND (n.name_pcode_nf = 'D2416' OR n.imdb_id > 2000)
  AND n.gender = 'm';
