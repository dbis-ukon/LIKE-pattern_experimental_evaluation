SELECT t.id, ci.person_id
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE '_r%gi%'
  AND t.title LIKE '(#1.%9)'
  AND (n.name LIKE '%elb_rg_ _.' OR n.name LIKE 'C_erno_f_ Al_an')
  AND akat.title LIKE '_in%ng%a%'
  AND co.name LIKE '%c%i%d%l%'
  AND cn.name LIKE 'Man Med Bag_ge'
  AND ci.person_id > 1173519
  AND t.production_year BETWEEN 1993 AND 2004
  AND n.gender = 'm'
  AND mc.company_id > 18031;
