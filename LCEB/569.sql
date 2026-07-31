SELECT a.title, c.name, co.name
FROM aka_title a
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
WHERE a.title LIKE 'Un%g_r'
   OR c.name LIKE '_e_gl_n%'
   OR co.name LIKE '%l_eni%V%eo E%erp_is_s (HVE)'
   AND a.production_year = 1960;
