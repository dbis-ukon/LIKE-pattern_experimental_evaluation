SELECT t.title, n.name AS actor_name, co.name AS company_name, k.keyword
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE t.title LIKE 'Pe_ d%e_ija ''Bor_e_'
  AND n.name LIKE 'Cr_mo_a%e'
  AND k.keyword LIKE 'a%-l_t_no-c_st'
  AND co.name LIKE '%na%F%';
