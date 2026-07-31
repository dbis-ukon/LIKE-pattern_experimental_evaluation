SELECT
    co.name AS company_name,
    COUNT(DISTINCT t.id) AS movie_count,
    AVG(t.season_nr) AS avg_season
FROM company_name co
JOIN movie_companies mc ON co.id = mc.company_id
JOIN title t ON mc.movie_id = t.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name c ON ci.person_role_id = c.id
WHERE c.name LIKE 'H_ra_ A. Good'
  AND t.season_nr > 1
  AND t.production_year >= 2001
GROUP BY co.name
ORDER BY movie_count DESC;
