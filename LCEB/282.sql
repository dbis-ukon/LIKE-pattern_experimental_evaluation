SELECT ci.movie_id, n.name AS lead_actor, t.title, co.name AS studio_name, k.keyword
FROM cast_info ci
JOIN name n ON ci.person_id = n.id
JOIN title t ON t.id = ci.movie_id
JOIN movie_companies mc ON mc.movie_id = t.id
JOIN company_name co ON co.id = mc.company_id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE t.title LIKE '(#2.167)'
  AND n.name LIKE 'Ba%er'
  AND n.name LIKE 'Wo%J_stin'
  AND k.keyword LIKE 'k_s_ing_someon%s-%k'
  AND co.name LIKE 'P% %oer C%pa_y';
