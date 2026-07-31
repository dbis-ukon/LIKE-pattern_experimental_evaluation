SELECT n.id, n.name, n.imdb_id, n.surname_pcode,
       ci.role_id, cn.name AS character_name
FROM name n
JOIN cast_info ci ON n.imdb_id = ci.person_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE (n.name LIKE 'K%lj%' OR n.name LIKE '_u_t%la_i')
  AND n.name LIKE 'Ca_do_o'
  AND n.imdb_id > 2000
  AND ci.nr_order <= 11;
