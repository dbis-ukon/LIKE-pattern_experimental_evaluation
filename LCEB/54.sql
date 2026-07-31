SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE akat.title LIKE '_r%y %o_s'
  AND k.keyword LIKE 'i%d%d_l_t_'
  AND cn.name LIKE 'Kelly k_nnedy'
  AND ci.nr_order <= 3
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
