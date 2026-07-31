SELECT n.id, n.name, n.imdb_id, n.md5sum,
       mc.company_type_id, c.name AS company_name
FROM name n
JOIN movie_companies mc ON n.imdb_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE (n.name LIKE '%ede%r_dr%' OR n.name LIKE 'Le%er')
  AND n.name LIKE 'Ty_e'
  AND (n.gender = 'f' OR n.imdb_id > 1000)
  AND c.country_code = '[es]';
