SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE cn.name LIKE 'The_Bio%O_d_Lad_'
  AND cn.name LIKE '%ari%'
  AND cn.name_pcode_nf LIKE '%VL%'
  AND (akat.title LIKE 'Beautiful Woman' OR akat.title LIKE 'Ardit_ dell''ari_')
  AND akat.title LIKE '_i%M%d%r%l%'
  AND akat.season_nr BETWEEN 1 AND 4
  AND akat.episode_nr BETWEEN 13 AND 28
  AND akat.production_year > 1968
  AND ci.nr_order <= 1
  AND akat.phonetic_code LIKE '%V%'
GROUP BY cn.name, ci.role_id
ORDER BY num_movies DESC;
