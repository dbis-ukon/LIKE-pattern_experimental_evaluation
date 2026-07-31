SELECT t.id, akat.kind_id
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (k.keyword LIKE '_addl_ng-a-boat' OR k.keyword LIKE 'ch_ese_and-_in_')
  AND t.title LIKE '%im%k%j%'
  AND n.name LIKE 'Devereaux'
  AND akat.title LIKE '_ead%'
  AND co.name LIKE '_fy _r_duc%o_'
  AND cn.name LIKE '_ak%o'
  AND akat.kind_id = 1
  AND t.production_year = 1951
  AND ci.nr_order <= 14
  AND mc.company_type_id = 1;
