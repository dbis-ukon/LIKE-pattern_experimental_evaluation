SELECT t.series_years, cn.name AS villain_name, MAX(akat.production_year) AS latest_year, c.name AS company_name
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE (cn.name LIKE '%d_le_ne _ilard' OR cn.name LIKE '% _a_G_eg%')
  AND (n.name LIKE 'S_lim' OR n.name LIKE 'Mizukami')
  AND n.gender = 'm'
  AND (t.title LIKE 'Hi%Waiti_g Career' OR t.title LIKE 'F_m%Gu% %e_Ma%n_ _f%d %Th%e_W% _ew%')
  AND ct.kind = 'production companies'
GROUP BY t.series_years, cn.name, c.name
ORDER BY latest_year DESC;
