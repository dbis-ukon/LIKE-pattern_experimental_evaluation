SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       k.keyword AS keyword,
       lt.link AS link_type
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_link ml ON akat.movie_id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE '_im%f_-%us _nd%Ch_in'
  AND cn.name LIKE '%ián%g%'
  AND akat.title LIKE 'Tra% %ss%l%ra%n'
  AND n.name LIKE '_h_mp_on'
  AND k.keyword LIKE '%ale-_ruck-d_ive_'
  AND lt.link LIKE '%spin-off%'
  AND ci.nr_order <= 3
GROUP BY cn.name, ci.role_id, n.name, k.keyword, lt.link
ORDER BY num_movies DESC;
