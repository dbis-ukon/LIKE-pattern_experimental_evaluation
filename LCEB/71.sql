SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS num_movies,
       MAX(akat.production_year) AS latest_year,
       n.name AS actor_name,
       k.keyword AS keyword,
       mi.note AS movie_note
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_info mi ON akat.movie_id = mi.movie_id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE cn.name LIKE '%ec #2'
  AND cn.name LIKE 'Celia Sayers'
  AND akat.title LIKE 'Der Wüstling'
  AND n.name LIKE '_amos'
  AND k.keyword LIKE 'me%y_prank_ter_'
  AND mi.note LIKE '%remastered%'
  AND ci.nr_order <= 9
GROUP BY cn.name, ci.role_id, n.name, k.keyword, mi.note
ORDER BY num_movies DESC;
