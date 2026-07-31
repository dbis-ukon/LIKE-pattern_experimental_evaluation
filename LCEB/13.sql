SELECT t.id, t.title
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE t.production_year BETWEEN 2008 AND 2011
  AND kt.kind = 'movie'
  AND rt.role = 'guest'
  AND n.gender = 'f'
  AND ct.kind = 'production companies'
  AND c.country_code = '[us]'
  AND t.title LIKE 'B%z O_f!'
  AND cn.name LIKE 'SA_ Staf_'
  AND k.keyword LIKE '_li_i_a_ion-round';
