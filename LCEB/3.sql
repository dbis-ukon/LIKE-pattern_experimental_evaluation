SELECT t.id, t.title, COUNT(DISTINCT ci.person_id) AS actors_count, COUNT(DISTINCT mc.company_id) AS companies_count
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
JOIN aka_title akat ON t.id = akat.movie_id
WHERE t.title LIKE '_h%ef%Aw_y'
  AND cn.name LIKE '%E_per_ #_'
  AND n.name NOT LIKE '%r_i_'
  AND akat.title NOT LIKE '_a giovan_ _iana'
  AND k.keyword LIKE 'four-st_r-general'
  AND (c.name LIKE '_o%i% _nt_r%i%en_' OR ct.kind = 'distributors')
  AND t.production_year < 1963
  AND ci.nr_order <= 5
GROUP BY t.id, t.title;
