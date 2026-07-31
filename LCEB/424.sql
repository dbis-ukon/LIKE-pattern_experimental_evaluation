SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       kt.kind AS kind_name, mc.note AS company_note
FROM aka_title akat
JOIN kind_type kt ON akat.kind_id = kt.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
WHERE akat.title LIKE 'Y%yy%d'
  AND akat.production_year >= 1968
  AND akat.kind_id IN (4, 7, 1, 3)
  AND kt.kind LIKE 'Series%'
  AND mc.note IS NOT NULL;
