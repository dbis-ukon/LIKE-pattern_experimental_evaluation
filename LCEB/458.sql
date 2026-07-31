SELECT n.id, n.name, n.md5sum,
       ci.role_id, cn.name AS character_name
FROM name n
JOIN cast_info ci ON n.imdb_id = ci.person_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE n.name LIKE '%he%Al_ira'
  AND (n.name_pcode_nf = 'M2535' OR n.surname_pcode = 'B4')
  AND n.imdb_id IS NOT NULL
  AND ci.nr_order <= 2;
