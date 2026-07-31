SELECT akat.movie_id, akat.title, MAX(akat.production_year) AS latest_year, COUNT(DISTINCT ci.person_id) AS main_cast
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
WHERE akat.title LIKE 'I%Happened in_''43'
  AND cn.name LIKE 'Pe_er Knight'
  AND ci.nr_order <= 10
  AND akat.production_year BETWEEN 1957 AND 1966
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
