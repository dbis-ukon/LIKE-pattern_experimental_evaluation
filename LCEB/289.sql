SELECT t.title, n.name AS lead_actor, co.name AS studio_name, k.keyword
FROM cast_info ci
JOIN name n ON n.id = ci.person_id
JOIN title t ON t.id = ci.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE t.title LIKE 'Lost_L%ers'
  AND n.name LIKE '%or_ Ay_u_'
  AND n.name LIKE 'Nordwall'
  AND k.keyword LIKE '_e%i%a_l_a_'
  AND co.name LIKE 'International Filmexport';
