SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       COUNT(DISTINCT k1.keyword) AS primary_keywords,
       COUNT(DISTINCT k2.keyword) AS secondary_keywords
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk1 ON akat.movie_id = mk1.movie_id
JOIN keyword k1 ON mk1.keyword_id = k1.id
JOIN movie_keyword mk2 ON akat.movie_id = mk2.movie_id
JOIN keyword k2 ON mk2.keyword_id = k2.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE ci.nr_order <= 1
  AND akat.production_year BETWEEN 1929 AND 1957
  AND cn.name LIKE '_h%P_z_a%uy'
  AND n.name LIKE 'C%za-%re'
  AND k1.keyword LIKE '%ne-%o_g'
  AND k2.keyword LIKE 'seltz_r-bott_e'
  AND lt.link LIKE '%sequel%'
  AND c.country_code = '[cl]'
  AND akat.title LIKE 'Da% of Glory'
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
