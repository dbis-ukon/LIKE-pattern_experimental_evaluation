SELECT n.id, n.name, n.gender, n.imdb_index, n.imdb_id,
       akat.title, akat.production_year
FROM name n
JOIN aka_title akat ON n.imdb_id = akat.movie_id
WHERE (n.name LIKE '%tö% %' OR n.name LIKE 'Dawson')
  AND n.gender = 'f'
  AND n.imdb_id > 1000
  AND akat.production_year BETWEEN 1967 AND 2012;
