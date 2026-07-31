SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT cn.id) AS num_characters
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
WHERE akat.title LIKE '%nd_Fi_d%t'
  AND k.keyword LIKE 'chica_o-vi%'
  AND cn.name LIKE 'Philipp_ %rioux'
  AND lt.link = 'followed by'
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
