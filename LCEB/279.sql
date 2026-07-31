SELECT a.title, c.name, co.name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'Primadonnas: Rebels Without a_Clue'
  AND c.name LIKE '%n_e%a%I%'
  AND co.name LIKE 'Film Noir Group'
  AND co.name LIKE '_e_usa H%e Video';
