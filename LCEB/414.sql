SELECT akat.movie_id, akat.title, COUNT(DISTINCT ci.person_id) AS main_cast, MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE '_ice%e'
  AND cn.name LIKE '_ar%'
  AND k.keyword LIKE '_oplar'
  AND c.name LIKE 'G%é% %'
  AND ci.nr_order <= 1
  AND akat.production_year BETWEEN 2007 AND 2008
  AND mc.company_type_id IN (2, 1)
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
