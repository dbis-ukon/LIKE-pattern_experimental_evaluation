SELECT t.id, t.title, c.name AS company, ct.kind
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE 'O%A%'
  AND c.name LIKE '%ion% _ssoc%io%o%r%'
  AND ct.kind LIKE '%production%'
  AND k.keyword LIKE 'numb%-86-as-ch_rac_e%n%e'
  AND mc.company_type_id = 2
  AND t.episode_nr >= 8;
