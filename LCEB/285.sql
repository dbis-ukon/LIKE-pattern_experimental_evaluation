SELECT t.title, n.name AS hero_actor, co.name AS studio_name, k.keyword
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '_we_Beas_/H_ro_n Twosom_/_o_d%Store/B_rm%e _a_ily'
  AND n.name LIKE 'D_a_i% %'
  AND n.name LIKE '%tk_ns%'
  AND k.keyword LIKE '%i%s'
  AND co.name LIKE 'Christobel Films';
