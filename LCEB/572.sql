SELECT t.title, n.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'wea_on_productio_'
  AND t.title LIKE '_20%-%'
  AND n.name LIKE '_os%r_'
  AND akat.title LIKE 'P%h %fe'
  AND co.name LIKE '_91 Cine'
  AND cn.name LIKE 'Rich %e_i_'
  AND t.production_year >= 2009
  AND ci.role_id = 3
  AND mc.company_type_id = 2
  AND t.episode_nr IS NULL;
