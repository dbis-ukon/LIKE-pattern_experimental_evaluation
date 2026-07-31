SELECT t.title, n.name AS supporting_hero, co.name AS company_name, k.keyword
FROM movie_companies mc
JOIN company_name co ON mc.company_id = co.id
JOIN title t ON mc.movie_id = t.id
JOIN cast_info ci ON ci.movie_id = t.id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '%002-08-_6)'
  AND n.name LIKE '_u%l'
  AND n.name LIKE '_o%F_lo_'
  AND k.keyword LIKE '_i_s%-_ar'
  AND co.name LIKE 'L.A.M.E. Prod_ctions';
