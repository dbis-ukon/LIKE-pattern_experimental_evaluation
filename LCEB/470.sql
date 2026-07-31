SELECT n.id, n.name, n.gender, n.surname_pcode,
       ci.role_id, cn.name AS character_name
FROM name n
JOIN cast_info ci ON n.imdb_id = ci.person_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE (n.name LIKE 'Hinkl_y' OR n.name LIKE '_a%a%')
  AND n.name LIKE '_i%w_'
  AND n.gender = 'f'
  AND ci.nr_order <= 3;
