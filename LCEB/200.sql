SELECT
    a.title AS aka_title,
    c.name AS hero_name,
    COUNT(DISTINCT ml.movie_id) AS num_sequels
FROM aka_title a
JOIN cast_info ca ON a.movie_id = ca.movie_id
JOIN char_name c ON ca.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON a.movie_id = t.id
JOIN movie_link ml ON a.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
WHERE a.title LIKE '%R%od%f_O%'
  AND t.title LIKE 'C_i_b_a_se'
  AND c.name LIKE 'Mrs. Tre_ayne'
  AND co.country_code = '[us]'
  AND co.name LIKE '%ä%'
  AND k.keyword LIKE '_n%-%ki%hi%'
  AND ca.nr_order BETWEEN 5 AND 10
  AND lt.link LIKE '%Sequel%'
GROUP BY a.title, c.name
ORDER BY num_sequels DESC;
