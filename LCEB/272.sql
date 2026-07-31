SELECT a.title, c.name, co.name
FROM aka_title a
JOIN cast_info ci ON a.movie_id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN movie_companies mc ON a.movie_id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE a.title LIKE 'Why_We Fight_ 2'
  AND c.name LIKE '_a_am_ Ben-David'
  AND co.name LIKE '_u%i%a%Di%b%r_'
  AND a.title LIKE '%S%C% %loo%ig%o%';
