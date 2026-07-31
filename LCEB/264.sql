SELECT a.title, c.name AS character_name, co.name AS company_name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE '%s_Icel%d'
  AND c.name LIKE 'Ti%u%n_'
  AND co.name LIKE 'North% Sout%P_o_uct_o_s';
