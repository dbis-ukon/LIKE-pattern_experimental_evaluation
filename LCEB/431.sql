SELECT akat.id, akat.movie_id, akat.title, akat.imdb_index, akat.kind_id, akat.production_year, akat.phonetic_code,
       akat.episode_of_id, akat.season_nr, akat.episode_nr, akat.note, akat.md5sum,
       c.name AS company_name, mc.note AS company_note
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE (akat.title LIKE '_inal%a%as_ C_ysta%r_n%l_s_ My_Life_as_a Ki%' OR akat.title LIKE '%e%i_y%t_o_t Windo_s')
  AND akat.episode_nr >= 17
  AND akat.kind_id IN (4, 1, 2)
  AND c.country_code = '[gb]'
  AND mc.note IS NOT NULL;
