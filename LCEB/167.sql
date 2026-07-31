SELECT a.title, COUNT(DISTINCT ci.person_id) AS cast_count
FROM aka_title a
JOIN cast_info ci ON ci.movie_id = a.movie_id
JOIN char_name cn ON cn.id = ci.person_id
JOIN role_type rt ON rt.id = ci.role_id
WHERE a.title LIKE 'Fo%d''ur_o'
  AND rt.role LIKE '%Lead%'
  AND a.season_nr >= 1
  AND ci.nr_order <= 20
GROUP BY a.title
ORDER BY cast_count DESC;
