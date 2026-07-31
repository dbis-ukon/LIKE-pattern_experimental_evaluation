SELECT DISTINCT t.title, c.name AS character_name, co.name AS company_name, k.keyword, n.name AS subject_name
FROM title t
JOIN aka_title a ON t.id = a.movie_id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name c ON ci.person_role_id = c.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN complete_cast cc ON t.id = cc.movie_id
WHERE (t.title LIKE '%ö_' OR c.name LIKE '_r_nn_i%P%est' OR k.keyword LIKE '_a%o_-r%pl_y')
  AND co.name LIKE '%t_M%-A_M%i_'
  AND n.name LIKE '_an_aste_'
  AND t.production_year > 2005
  AND t.production_year <= 1998
  AND co.country_code = '[eg]'
  AND ci.nr_order < 28
  AND n.gender = 'm';
