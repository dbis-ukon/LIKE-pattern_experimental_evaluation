SELECT t.title
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'plea-for-protection'
  AND t.title LIKE '% Ei%la_g_m_t dem_U_iversum'
  AND n.name LIKE '%oz_ %a'
  AND akat.title LIKE 'Quinte_t mit Harfe%d Trom_ete'
  AND co.name LIKE 'Mal%n'
  AND cn.name LIKE '% %x'
  AND t.production_year >= 2012
  AND ci.role_id >= 1
  AND mc.company_type_id >= 1
  AND t.kind_id = 7;
