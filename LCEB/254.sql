SELECT t.series_years, cn.name AS villain_name, MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
WHERE (cn.name LIKE 'Mark - Jon Jon''s Be_t Friend' OR cn.name LIKE 'Edwa_d Jos_ph_''_ed_ _os_er')
  AND (n.name LIKE 'Fedo_enko' OR n.name LIKE 'D%y%J_hn')
  AND n.gender = 'm'
  AND (t.title LIKE '_h%e of%' OR t.title LIKE 'In%der')
GROUP BY t.series_years, cn.name
ORDER BY latest_year DESC;
