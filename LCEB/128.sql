SELECT co.name, COUNT(DISTINCT t.id) AS movie_count, MAX(t.production_year) AS last_year
FROM company_name co
JOIN movie_companies mc ON mc.company_id = co.id
JOIN title t ON t.id = mc.movie_id
WHERE (co.name LIKE '_ic%o_eon L_ti%America (Nic%Lat_no_' OR co.name LIKE 'Lit_le_Fish_E% Big F%h (_FEBF_')
  AND t.production_year BETWEEN 2000 AND 2002
GROUP BY co.name
ORDER BY last_year DESC;
