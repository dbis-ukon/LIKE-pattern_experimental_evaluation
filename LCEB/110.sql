SELECT cn.name, COUNT(DISTINCT ci.movie_id) AS movie_count, MAX(t.production_year) AS last_year
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
WHERE (cn.name LIKE 'Su_t%a%' OR cn.name LIKE 'Lt. _ol. Chand_er')
  AND t.production_year BETWEEN 2005 AND 2013
  AND ci.nr_order <= 9
GROUP BY cn.name
ORDER BY last_year DESC;
