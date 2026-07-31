SELECT id, name, imdb_index
FROM name n
WHERE (n.name LIKE '_oo%rd' OR n.name LIKE 'D%m_r')
  AND n.surname_pcode LIKE 'O%'
  AND n.imdb_id > 5000;
