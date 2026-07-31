SELECT t.series_years,
       cn.name AS villain_name,
       MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE cn.name LIKE '%r_h%'
  AND n.gender = 'f'
  AND t.title LIKE 'L% _11%T_e%Co%ic%'
GROUP BY t.series_years, cn.name
ORDER BY latest_year DESC;
