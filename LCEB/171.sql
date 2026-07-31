SELECT a.title, COUNT(DISTINCT mc.company_id) AS companies, MAX(a.production_year) AS last_year
FROM aka_title a
JOIN movie_companies mc ON mc.movie_id = a.movie_id
JOIN company_name co ON co.id = mc.company_id
WHERE a.title LIKE 'Pa%i% Chéreau'
  AND co.country_code = '[fr]'
  AND mc.note LIKE '%Productions%'
  AND a.season_nr = 35
GROUP BY a.title
ORDER BY last_year DESC;
