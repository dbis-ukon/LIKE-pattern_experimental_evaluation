SELECT id, name, imdb_id, surname_pcode
FROM name n
WHERE (n.name LIKE '%r% %R%m%d_P_' OR n.name LIKE '%e%le')
  AND n.name LIKE 'Ta%ra'
  AND n.imdb_id > 2000;
