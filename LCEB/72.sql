SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       c.name AS company_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE cn.name LIKE '_r%i%f_'
  AND cn.name LIKE 'O_r_-_e_n'
  AND akat.title LIKE 'S_uola di polizi_ III: tutto da rifare'
  AND n.name LIKE 'Al_en'
  AND c.name LIKE 'La_a %tertainment'
  AND ci.nr_order <= 7
GROUP BY cn.name, ci.role_id, n.name, c.name
ORDER BY num_movies DESC;
