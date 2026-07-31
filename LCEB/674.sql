SELECT DISTINCT t.title, n.name, k.keyword, co.name AS company
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
JOIN aka_title akat ON t.id = akat.movie_id
WHERE mc.note IS NULL
  AND n.name LIKE '%o%ad'
  AND t.kind_id IN (1, 6, 7, 2)
  AND t.production_year BETWEEN 1910 AND 2000
  AND t.title LIKE '_#%._8_'
  AND co.country_code IN ('[au]', '[us]', '[jp]', '[be]', '[gb]')
  AND cn.name LIKE '%ek%th%'
  AND t.season_nr IS NULL
  AND (akat.title LIKE '_l_i%s %l%' OR akat.title LIKE 'D_ango_-%c%ß%i%L_ed v_m_St_rb_n')
ORDER BY t.title
LIMIT 150;
