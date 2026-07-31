SELECT akat.movie_id,
       akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       STRING_AGG(DISTINCT cn.name, ', ') AS characters
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
WHERE (akat.title LIKE '_a_m% bla%' OR akat.title LIKE '_×_ Ä%Ç%ÇÕ%Ô%')
  AND k.keyword LIKE '%y-_an-_es_ia_-_o%n%e_a_io%hip'
  AND rt.role = 'miscellaneous crew'
  AND ci.nr_order <= 14
  AND akat.production_year BETWEEN 1917 AND 1960
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
