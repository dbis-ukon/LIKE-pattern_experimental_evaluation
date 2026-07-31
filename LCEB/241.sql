SELECT akat.movie_id,
       t.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.production_year) AS latest_year,
       cn.name AS character_name,
       ci.role_id
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE '%t_r %r_e_'
  AND n.name LIKE 'Ba%r'
  AND ci.nr_order <= 8
  AND akat.title LIKE 'Raggedy - E_ne G_schichte von Liebe'
  AND t.title LIKE 'Motór'
  AND k.keyword LIKE 'referenc_-to-childe-harold''_-pilgrimage'
  AND k.keyword LIKE '%i%u_n%s'
  AND akat.production_year >= 1978
GROUP BY akat.movie_id, t.title, cn.name, ci.role_id
ORDER BY latest_year DESC;
