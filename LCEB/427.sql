SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       c.name AS company_name, mc.note AS company_note
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE '%l_n%d'
  AND akat.production_year BETWEEN 1989 AND 2010
  AND akat.kind_id = 1
  AND c.country_code = '[us]'
  AND mc.note IS NOT NULL;
