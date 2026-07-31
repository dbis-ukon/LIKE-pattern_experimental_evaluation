SELECT n.name, t.title, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE ci.nr_order <= 47
  AND t.title LIKE '%f_i_e% %'
  AND n.name LIKE 'S%r'
  AND k.keyword LIKE '_o_di%la_ndr_'
  AND t.kind_id = 1
  AND k.phonetic_code IS NOT NULL
ORDER BY n.name;
