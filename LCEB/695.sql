SELECT n.id, n.name, n.gender, COUNT(DISTINCT t.id) AS n_titles
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN title t ON ci.movie_id = t.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE n.name LIKE 'Swift'
  AND t.title NOT LIKE 'M_rtí_ Rivas'
  AND cn.name LIKE '%a%c%a%'
  AND k.keyword LIKE '%r%-t_-f_anca-m_rzi'
  AND co.name LIKE '%orie_Produc_io%LLC'
  AND ci.nr_order <= 22
  AND ci.nr_order IS NOT NULL
  AND n.gender IN ('f', 'm')
  AND ci.role_id IN (5, 10, 1, 3, 2)
  AND co.country_code IN ('[us]', '[sg]', '[be]', '[lv]', '[br]')
  AND t.kind_id IN (7, 2, 3, 1)
  AND n.imdb_id IS NOT NULL
  AND n.name_pcode_nf IS NOT NULL
GROUP BY n.id, n.name, n.gender
HAVING COUNT(DISTINCT t.id) >= 5
ORDER BY n_titles DESC
LIMIT 30;
