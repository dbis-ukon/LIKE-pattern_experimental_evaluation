SELECT t.title, n.name AS villain_actor, co.name AS company_name, k.keyword
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE t.title LIKE '_#1.%8)'
  AND n.name LIKE 'Ch_osc_cki'
  AND n.name LIKE '%me_n% %t%'
  AND k.keyword LIKE 'g_a%-%tist'
  AND co.name LIKE 'Pa_a%a% Producci%';
