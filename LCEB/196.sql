SELECT
    n.name,
    COUNT(DISTINCT mc.company_id) AS companies,
    MAX(a.production_year) AS last_year
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN movie_companies mc ON mc.movie_id = ci.movie_id
JOIN company_name co ON co.id = mc.company_id
JOIN aka_title a ON a.movie_id = ci.movie_id
WHERE n.name LIKE 'Oonk'
  AND co.country_code = '[gb]'
  AND mc.note LIKE '%Studio%'
  AND a.episode_nr > 8
GROUP BY n.name
ORDER BY last_year DESC;
