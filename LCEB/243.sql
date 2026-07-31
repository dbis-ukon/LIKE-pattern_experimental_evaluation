SELECT  cn.name AS character_name, MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE 'Hers_lf - Former Analyst_ _ongressional _udget %cer'
  AND t.title LIKE '_#1_44)'
GROUP BY cn.name
ORDER BY latest_year DESC;
