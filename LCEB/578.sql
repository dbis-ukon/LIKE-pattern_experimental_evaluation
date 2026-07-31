SELECT t.title, co.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE 'gilleys-nightcl_b'
  AND t.title LIKE '_ec%s'
  AND n.name LIKE 'V_ncen%To_y'
  AND akat.title LIKE 'Q%a vi_i_sa d_ m_a m_gl%'
  AND co.name LIKE 'Z%ia% Producc%n%'
  AND cn.name LIKE 'Keiko Ikuno'
  AND t.production_year BETWEEN 1995 AND 2010
  AND ci.role_id = 2
  AND mc.company_type_id >= 1
  AND t.kind_id = 1;
