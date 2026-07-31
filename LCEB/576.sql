SELECT co.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'me%-_e%r%p'
  AND t.title LIKE 'Rip%'
  AND n.name LIKE '%rrma%a%'
  AND akat.title LIKE '%iu_p_marsch'
  AND co.name LIKE 'Fer_-Fi%G_bH'
  AND cn.name LIKE '%n%e_Wa_r_ngt%'
  AND t.production_year >= 1992
  AND ci.role_id = 2
  AND mc.company_type_id = 2
  AND t.kind_id = 7;
