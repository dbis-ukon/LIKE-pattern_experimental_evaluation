SELECT t.title, n.name AS actor_name, co.name AS company_name, k.keyword
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE t.title LIKE 'T% _o_ _h_ %n_e'
  AND n.name LIKE 'Bach'
  AND k.keyword LIKE '%tl%i%'
  AND co.name LIKE 'C_rvel_ Productions';
