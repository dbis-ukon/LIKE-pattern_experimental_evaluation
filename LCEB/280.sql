SELECT a.title, c.name AS character_name, k.keyword, co.name AS company_name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE '_isou _ijo sh%ai'
  AND c.name LIKE 'M%D_n%'
  AND k.keyword LIKE 'start-_-_ew-life-f_om-scratch'
  AND co.name LIKE '_mex%';
