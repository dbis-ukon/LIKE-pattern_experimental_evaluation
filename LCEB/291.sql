SELECT t.title, n.name AS villain_actor, co.name AS company_name, k.keyword
FROM cast_info ci
JOIN name n ON ci.person_id = n.id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE t.title LIKE '_cos _e esper%a par_e_1_ _mar%s_r_cuerdos'
  AND n.name LIKE '_h%o'
  AND n.name LIKE '_iva_'
  AND k.keyword LIKE '_isg%sed-a_-%chic_e_'
  AND co.name LIKE 'TREE';
