SELECT t.id FROM title t
JOIN aka_title akat ON t.id=akat.movie_id
JOIN movie_keyword mk ON t.id=mk.movie_id
JOIN keyword k ON mk.keyword_id=k.id
JOIN cast_info ci ON t.id=ci.movie_id
JOIN name n ON ci.person_id=n.id
JOIN char_name cn ON ci.person_role_id=cn.id
JOIN movie_companies mc ON t.id=mc.movie_id
JOIN company_name co ON mc.company_id=co.id
WHERE k.keyword LIKE '_ype%ti_it_'
AND t.title LIKE 'Frame 313: A new perspective on JFK Assasination _heories'
AND n.name LIKE '%a%e%e_'
AND akat.title LIKE '%c_i%en'
AND co.name LIKE 'Terrada Warehouse'
AND cn.name LIKE 'Neal %a_n_c_'
AND t.production_year = 1968
AND ci.role_id = 10
AND mc.company_type_id = 2
AND t.kind_id = 7;
