SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       c.name AS company_name, mc.note AS company_note
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE '_h_ _asty Girl'
  AND akat.production_year >= 2008
  AND akat.md5sum IS NOT NULL
  AND c.country_code = '[be]'
  AND mc.note IS NOT NULL;
