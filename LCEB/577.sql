SELECT t.id, n.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE '_u_s%n-_k_'
  AND t.title LIKE '% v%t_I% %w% % %D_y%'
  AND n.name LIKE 'Ror_e% Mis_y'
  AND akat.title LIKE 'H_me'
  AND co.name LIKE 'Li%o%o%'
  AND cn.name LIKE '%r_La%'
  AND t.production_year = 2005
  AND ci.nr_order < 1
  AND mc.company_id >= 9851
  AND t.kind_id = 7;
