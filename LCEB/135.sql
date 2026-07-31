SELECT t.title, COUNT(DISTINCT mc.company_id) AS companies, MAX(t.production_year) AS last_year
FROM title t
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE t.title LIKE 'La d%rota _e_Al_o_s_'
  AND t.production_year BETWEEN 1935 AND 2003
  AND co.country_code = '[th]'
  AND mc.note LIKE '%Studio%'
  AND t.kind_id IN (2, 7, 3, 1)
GROUP BY t.title
ORDER BY last_year DESC;
