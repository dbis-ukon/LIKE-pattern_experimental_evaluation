SELECT id, name, gender, imdb_index
FROM name n
WHERE (n.name LIKE 'M%é_C%ss_ A%' OR n.name LIKE '_o_m_s')
  AND n.name LIKE 'Tenn_r'
  AND n.surname_pcode LIKE 'H%';
