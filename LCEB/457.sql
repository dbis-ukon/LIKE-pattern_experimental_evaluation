SELECT n.id, n.name, n.imdb_index, n.surname_pcode,
       c.name AS company_name, mc.company_type_id
FROM name n
JOIN movie_companies mc ON n.imdb_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE (n.name LIKE 'B_c_m%' OR n.name LIKE 'Edwards' OR n.name LIKE '_a_c%n')
  AND n.gender = 'f'
  AND mc.company_type_id = 1;
