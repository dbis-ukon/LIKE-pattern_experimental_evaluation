SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       kt.kind AS kind_name, mc.note AS company_note
FROM aka_title akat
JOIN kind_type kt ON akat.kind_id = kt.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
WHERE akat.title LIKE 'The Walkers'
  AND akat.production_year < 1998
  AND akat.season_nr IS NOT NULL
  AND kt.kind LIKE 'Comedy%'
  AND mc.note IS NOT NULL;
