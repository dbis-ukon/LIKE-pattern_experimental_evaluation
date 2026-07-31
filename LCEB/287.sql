SELECT t.title, n.name AS villain_actor, co.name AS company_name, k.keyword
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE t.title LIKE 'D%y Cro_k%'
  AND n.name LIKE 'Delar_sa'
  AND n.name LIKE 'Fran_eneri_er_ Donovan'
  AND k.keyword LIKE '%f%e%e%t%'
  AND co.name LIKE 'C%amo Inc.';
