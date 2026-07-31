SELECT n.id, n.name, n.gender, n.name_pcode_cf,
       kt.kind AS kind_name
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
JOIN kind_type kt ON akat.kind_id = kt.id
WHERE n.name LIKE 'Gustafson_ Alexander'
  AND (n.gender = 'm' OR n.name LIKE 'Navarro_ _na E_ena')
  AND kt.kind LIKE 'Drama%';
