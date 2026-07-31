SELECT akat.movie_id, t.title, COUNT(DISTINCT cn.id) AS main_characters, c.name AS company_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN title t ON akat.movie_id = t.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE (cn.name LIKE 'Ha_lem _r_wn' OR cn.name LIKE 'A_so%n_esti%tor')
  AND (n.name LIKE '_a_l%n%L%i_' OR n.name LIKE 'Ke_n_al%')
  AND (t.title LIKE 'C%n_ _a_t%' OR t.title LIKE 'Gra%r_ot_: C%test%g Ohi_')
  AND n.gender = 'f'
  AND akat.production_year BETWEEN 1941 AND 2001
GROUP BY akat.movie_id, t.title, c.name
ORDER BY main_characters DESC;
