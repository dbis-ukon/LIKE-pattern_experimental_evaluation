SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       c.name AS company_name, mc.note AS company_note
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE '_o%r_m%an%o la_m_a%i_vine%a'
  AND akat.episode_nr IS NOT NULL
  AND akat.phonetic_code LIKE 'S%'
  AND c.country_code = '[us]';
