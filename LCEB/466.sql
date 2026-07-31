SELECT n.id, n.name, n.imdb_index, n.md5sum,
       ci.role_id, cn.name AS character_name
FROM name n
JOIN cast_info ci ON n.imdb_id = ci.person_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE (n.name LIKE 'Ellingson' OR n.name LIKE 'Zava_a')
  AND n.name LIKE 'Brock'
  AND (n.surname_pcode = 'W56' OR n.gender = 'm')
  AND ci.nr_order <= 9;
