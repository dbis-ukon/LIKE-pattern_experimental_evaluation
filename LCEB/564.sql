SELECT t.title, n.name AS director, co.name AS company, k.keyword
FROM cast_info ci
JOIN name n ON ci.person_id = n.id
JOIN title t ON t.id = ci.movie_id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '%e%ac_men_'
  AND n.name LIKE '_art'
  AND n.name LIKE 'Lima'
  AND k.keyword LIKE 'm%ion_com_c'
  AND co.name LIKE '%p%r_du_t%n_'
  AND ci.role_id IN (3, 9, 1, 8, 10);
