SELECT t.title, n.name AS actor_name, co.name AS company_name, k.keyword
FROM cast_info ci
JOIN name n ON ci.person_id = n.id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE t.title LIKE '% %of%7'
  AND n.name LIKE '%t%s'
  AND n.name LIKE 'Ra_hje Ellis'
  AND k.keyword LIKE 're%ence%-j_r%y_p%en'
  AND co.name LIKE '_h%of Jes_s C_r%t%f _at%-%y_Sa_nts';
