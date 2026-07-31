SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE (cn.name LIKE 'Jefferson Hathawa_' OR cn.name LIKE '% t% B_un%Hu%er')
  AND cn.name_pcode_nf LIKE '%VL%'
  AND cn.md5sum IS NOT NULL
  AND akat.season_nr BETWEEN 1 AND 1
  AND akat.episode_nr IS NOT NULL
  AND akat.production_year BETWEEN 1987 AND 1994
  AND akat.title LIKE '_l_p%e % %'
  AND ci.nr_order IN (19, 25, 3, 1, 11)
  AND akat.phonetic_code IS NOT NULL
GROUP BY cn.name, ci.role_id
ORDER BY num_movies DESC;
