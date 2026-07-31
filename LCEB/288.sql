SELECT t.title, n.name AS supporting_actor, co.name AS production_company, k.keyword
FROM movie_keyword mk
JOIN keyword k ON k.id = mk.keyword_id
JOIN title t ON t.id = mk.movie_id
JOIN cast_info ci ON ci.movie_id = t.id
JOIN name n ON n.id = ci.person_id
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
WHERE t.title LIKE '_u_g%a_in_ Pir%'
  AND n.name LIKE 'St_anglers'
  AND n.name LIKE '%x_e%'
  AND k.keyword LIKE 'or_ental'
  AND co.name LIKE 'Tex_s_28_Fi%';
