SELECT DISTINCT t.title, c.name AS char_name, co.name AS company_name, k.keyword, rt.role AS role_type, lt.link AS link_type
FROM aka_title a
JOIN title t ON a.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name c ON ci.person_id = c.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN movie_link ml ON t.id = ml.movie_id
JOIN link_type lt ON ml.link_type_id = lt.id
WHERE (t.title LIKE '_ohra_w_rdt advoc_at' OR c.name LIKE '%g_n_a%P_e' OR co.name LIKE 'Iro_ River Films' OR t.title LIKE '%r W_rld%e')
  AND k.keyword LIKE 'nude-girl'
  AND rt.role = 'producer'
  AND lt.link = 'referenced in'
  AND t.production_year >= 1910
  AND co.country_code = '[lv]'
  AND ci.nr_order > 1
  AND k.phonetic_code = 'O6313'
  AND mc.note = '(2009) (Philippines) (TV)'
  AND t.season_nr >= 5;
