SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       kt.kind AS kind_name, c.name AS company_name
FROM aka_title akat
JOIN kind_type kt ON akat.kind_id = kt.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE 'Estpolis'
  AND akat.production_year BETWEEN 2004 AND 2009
  AND akat.md5sum IS NOT NULL
  AND kt.kind LIKE 'Legend%'
  AND c.country_code = '[us]';
