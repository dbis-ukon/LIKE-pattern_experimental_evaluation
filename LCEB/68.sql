SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       c.name AS company_name,
       k.keyword AS keyword,
       mi.note AS movie_note
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE 'Evely_ %n_ck'
  AND cn.name LIKE 'F%efighter_Martin_''_a_y'' H_w_ho_n_'
  AND akat.title LIKE 'Le_fl_c d_ _emp_'
  AND n.name LIKE 'S_i_z_r'
  AND k.keyword LIKE 'm_x_ca_-la_m_n'
  AND c.name LIKE '% V%'
  AND mi.note LIKE '%special%'
  AND ci.nr_order <= 6
GROUP BY cn.name, ci.role_id, n.name, c.name, k.keyword, mi.note
ORDER BY num_movies DESC;
