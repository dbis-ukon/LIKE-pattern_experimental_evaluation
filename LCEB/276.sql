SELECT a.title, c.name, co.name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'The Great Mine Disaster'
  AND c.name LIKE 'M%ou%'
  AND co.name LIKE '3%l%'
  AND co.name LIKE '_a_amythia%P%d_c%ns';
