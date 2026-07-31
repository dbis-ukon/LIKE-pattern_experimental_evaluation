SELECT t.title, n.name AS lead_actor, k.keyword, co.name AS studio_name
FROM cast_info ci
JOIN name n ON n.id = ci.person_id
JOIN title t ON t.id = ci.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE t.title LIKE '_ol%lu_'
  AND n.name LIKE 'T_a_h%r%Pab%'
  AND n.name LIKE '_e _avil_and'
  AND k.keyword LIKE 'farmboy'
  AND co.name LIKE 'E_rop%A_ur_eda Col_eg_'
  AND ci.nr_order <= 24;
