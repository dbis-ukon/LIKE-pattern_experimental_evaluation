SELECT
    a.title AS aka_title,
    c.name AS character_name,
    rt.role AS role_type,
    lt.link AS movie_link
FROM aka_title a
JOIN cast_info ca ON a.movie_id = ca.movie_id
JOIN char_name c ON ca.person_id = c.id
JOIN role_type rt ON ca.role_id = rt.id
JOIN movie_link ml ON a.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN title t ON a.movie_id = t.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE a.title LIKE 'Wi% Her O%g%'
  AND t.title LIKE '_ea_h_r_s %'
  AND c.name LIKE 'Se%O%h%y'
  AND co.name LIKE 'L%n_F%s'
  AND k.keyword LIKE 'parking-lot'
  AND rt.role = 'cinematographer'
  AND lt.link LIKE '%Sequel%'
  AND ca.nr_order BETWEEN 11 AND 57
  AND co.country_code = '[us]'
GROUP BY a.title, c.name, rt.role, lt.link
ORDER BY a.title;
