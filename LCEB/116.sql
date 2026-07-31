SELECT co.name, t.title, t.production_year
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE co.name LIKE 'Sy Bartlett'
  AND t.production_year >= 1999
  AND (mc.note IS NOT NULL OR t.season_nr IS NOT NULL)
ORDER BY t.production_year DESC;
