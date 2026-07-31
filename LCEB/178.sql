SELECT
    n.name AS actor_name,
    COUNT(DISTINCT ci.person_role_id) AS character_count,
    MIN(t.production_year) AS first_year,
    MAX(t.production_year) AS last_year
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN role_type rt ON ci.role_id = rt.id
WHERE n.gender = 'f'
  AND rt.role LIKE '%actor%'
  AND t.production_year BETWEEN 2012 AND 2013
GROUP BY n.name
ORDER BY character_count DESC;
