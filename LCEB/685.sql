SELECT kt.kind, n.gender, COUNT(*) AS leading_roles
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE ci.nr_order = 22
  AND n.gender IN ('m', 'f')
  AND t.title LIKE '(%0_-0_-08)'
  AND cn.name LIKE 'Nakagaki'
  AND k.keyword LIKE '%b%l%a%'
  AND co.name LIKE 'B%be%t% P%du%ion_'
  AND co.country_code IN ('[gb]', '[hr]', '[in]', '[us]', '[tr]')
  AND ci.role_id IN (3, 10, 4, 2, 1)
  AND t.kind_id IN (7, 1, 3, 2)
  AND mc.note IS NULL
  AND n.imdb_id IS NOT NULL
GROUP BY kt.kind, n.gender
ORDER BY kt.kind, n.gender;
