SELECT
    co.name AS company_name,
    COUNT(DISTINCT t.id) AS movie_count,
    AVG(t.production_year) AS avg_year
FROM company_name co
JOIN movie_companies mc ON co.id = mc.company_id
JOIN title t ON mc.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (k.keyword LIKE 'u_izzi%u%-%ore_c_-i_a%' OR k.keyword LIKE 'uni_ers_ty-_f_s_dney')
  AND t.production_year >= 2012
GROUP BY co.name
ORDER BY movie_count DESC;
