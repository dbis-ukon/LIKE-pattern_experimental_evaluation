SELECT akat.movie_id, t.title, COUNT(DISTINCT cn.id) AS main_characters, c.name AS company_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN title t ON akat.movie_id = t.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE (cn.name LIKE 'C_r_sti_n Di_n_t_r_' OR cn.name LIKE '%r%S%r%')
  AND (n.name LIKE '%nç%es%r%' OR n.name LIKE 'Liu')
  AND (t.title LIKE '%t_ _a%' OR t.title LIKE '%cefu%Ha%n')
  AND n.gender = 'm'
  AND ct.kind = 'special effects companies'
  AND akat.production_year BETWEEN 2000 AND 2005
GROUP BY akat.movie_id, t.title, c.name
ORDER BY main_characters DESC;
