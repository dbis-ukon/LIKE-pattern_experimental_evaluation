SELECT akat.movie_id,
       t.title,
       k.keyword,
       cn.name AS character_name,
       ci.role_id,
       c.name AS company_name
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN title t ON akat.movie_id = t.id
WHERE ci.nr_order <= 3
  AND k.keyword LIKE 'h_r_e%s_-%r'
  AND cn.name LIKE 'Brion Sanders'
  AND n.name LIKE 'Bl%c_'
  AND t.title LIKE 'F_n % _om'
  AND akat.production_year >= 1986;
