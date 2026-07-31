SELECT t.id
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'lincol%assass_nation'
  AND t.title LIKE '_1%-24_'
  AND n.name LIKE 'Pallett'
  AND akat.title LIKE '%O% %'
  AND co.name LIKE '_NTA_Atel_er'
  AND cn.name LIKE 'Lemonad_ G_rl_a_ %m'
  AND t.production_year < 1993
  AND ci.nr_order >= 1
  AND mc.company_id >= 74784
  AND t.kind_id = 7;
