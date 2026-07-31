SELECT akat.movie_id, akat.title, MAX(akat.production_year) AS latest_year, COUNT(DISTINCT ci.person_id) AS main_cast
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE akat.title LIKE 'A_t_in_''%n_e_s'
  AND ci.nr_order <= 1
  AND akat.production_year BETWEEN 1955 AND 1957
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
