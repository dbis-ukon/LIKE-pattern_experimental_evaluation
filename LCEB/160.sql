SELECT n.name, MIN(a.production_year) AS first_year, MAX(a.production_year) AS last_year
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN aka_title a ON a.movie_id = ci.movie_id
WHERE n.name LIKE 'Ju%z'
  AND n.gender = 'm'
  AND a.episode_nr > 1
  AND a.season_nr >= 1
GROUP BY n.name
ORDER BY last_year DESC;
