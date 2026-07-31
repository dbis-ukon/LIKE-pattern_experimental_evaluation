SELECT k.keyword, co.name AS company_name, COUNT(DISTINCT t.id) AS movie_count
FROM keyword k
JOIN movie_keyword mk ON mk.keyword_id = k.id
JOIN title t ON t.id = mk.movie_id
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE k.keyword LIKE '%o_w%'
  AND co.name LIKE '%r_o %d%i%'
  AND co.country_code = '[us]'
  AND mc.company_type_id IS NOT NULL
GROUP BY k.keyword, co.name
ORDER BY movie_count DESC;
