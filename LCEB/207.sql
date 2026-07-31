SELECT
    co.name AS company_name,
    COUNT(DISTINCT cc.movie_id) AS movies_count
FROM complete_cast cc
JOIN title t ON cc.movie_id = t.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE co.name LIKE 'V_n-_el%t _r_ductio_s'
  AND t.season_nr >= 9
  AND t.episode_nr > 7
GROUP BY co.name
ORDER BY movies_count DESC;
