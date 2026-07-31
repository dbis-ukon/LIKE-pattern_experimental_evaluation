SELECT a.title, c.name, co.name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE '_ur%ner Fr_u %l_ebe'
  AND c.name LIKE '_eter R_dgw_ll'
  AND co.name LIKE '_aVinci Productions';
