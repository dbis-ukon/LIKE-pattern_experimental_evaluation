SELECT t.id, akat.production_year
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE k.keyword LIKE '%e%-%e%m%'
  AND (t.title LIKE '.%a%' OR t.title LIKE '_o%h%')
  AND n.name LIKE '%w%l%a'
  AND akat.title LIKE '_ero_Stu_f'
  AND co.name LIKE '_D_ _roduct%ns'
  AND cn.name LIKE 'Naomi_Blumenth_l'
  AND akat.production_year >= 2004
  AND t.production_year >= 2008
  AND ci.role_id = 9
  AND mc.company_id >= 1451;
