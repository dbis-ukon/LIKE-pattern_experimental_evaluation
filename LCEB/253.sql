SELECT  COUNT(DISTINCT akat.movie_id) AS num_movies
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN title t ON akat.movie_id = t.id
WHERE n.gender = 'm'
  AND t.kind_id = 7
  AND (t.title LIKE '%Li_bi %' OR t.title LIKE 'E Is for %gli_h')
  AND (n.name LIKE '%t%l_s_n' OR n.name LIKE '%n');
