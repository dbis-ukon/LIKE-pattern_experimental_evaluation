SELECT
    akat.movie_id,
    akat.title,
    COUNT(DISTINCT k.keyword) AS num_keywords,
    COUNT(DISTINCT ci.person_id) AS cast_size
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE (akat.title LIKE '_er%ü%Ma_n' OR akat.title LIKE 'C_l_')
  AND k.keyword LIKE '%n%n%e%ng-%c_n_ciou_-wo_a_'
  AND n.name LIKE 'O''Lag_e_ Paul'
  AND ci.nr_order <= 67
  AND akat.production_year BETWEEN 1988 AND 2000
GROUP BY akat.movie_id, akat.title
HAVING COUNT(DISTINCT k.keyword) > 2
ORDER BY cast_size DESC;
