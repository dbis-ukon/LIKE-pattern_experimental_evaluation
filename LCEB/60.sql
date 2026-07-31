SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE cn.name LIKE '%e%t%'
  AND cn.name_pcode_nf LIKE '%VL%'
  AND (akat.title LIKE '_ti%d% i_Åb_' OR akat.title LIKE 'M%s%2%ak% %u')
  AND akat.season_nr BETWEEN 1 AND 1
  AND akat.episode_nr BETWEEN 10 AND 16
  AND akat.production_year > 1988
  AND ci.nr_order <= 14
  AND cn.imdb_id IS NOT NULL
  AND akat.note IS NOT NULL
  AND akat.phonetic_code LIKE '%V%'
GROUP BY cn.name, ci.role_id
ORDER BY num_movies DESC;
