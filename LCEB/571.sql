SELECT t.id, co.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE '%ue%av_'
  AND t.title LIKE '_i_.%l_'
  AND n.name LIKE 'Le_n_myr%S_e%n'
  AND akat.title LIKE '%ÒÔ%Ð%Ì%'
  AND co.name LIKE 'Le_ F%s_C'
  AND cn.name LIKE '%v_ _a%'
  AND t.production_year BETWEEN 1928 AND 2011
  AND ci.nr_order < 1
  AND mc.company_id > 19
  AND t.kind_id = 1;
