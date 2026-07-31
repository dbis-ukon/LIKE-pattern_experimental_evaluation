SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE cn.name LIKE '%r%m_'
  AND cn.name_pcode_nf LIKE '%VL%'
  AND cn.surname_pcode IS NOT NULL
  AND akat.season_nr BETWEEN 1 AND 1
  AND akat.episode_nr >= 26
  AND akat.production_year >= 1938
  AND akat.title LIKE '_g%Fo%v_r'
  AND ci.nr_order <= 57
GROUP BY cn.name, ci.role_id
ORDER BY num_movies DESC;
