SELECT cn.name, COUNT(DISTINCT ci.movie_id) AS appearances
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
WHERE cn.name LIKE 'M_ _af%'
  AND t.season_nr = 21
  AND t.production_year BETWEEN 1910 AND 2005
  AND ci.nr_order <= 9
GROUP BY cn.name
ORDER BY appearances DESC;
