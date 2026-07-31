SELECT a.title, n.name, co.name AS company_name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'K% %ai'
  AND n.name LIKE 'Co%y%'
  AND co.name LIKE '_n% %1'
  AND a.production_year >= 1969
  AND a.season_nr = 1
  AND mc.company_type_id IS NOT NULL;
