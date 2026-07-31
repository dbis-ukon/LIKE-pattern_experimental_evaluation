SELECT t.id, akat.title, mc.note
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE 'm_me-d%r'
)
  AND akat.title LIKE 'A Strange_ That _ight'
  AND co.name LIKE '_de% N_mo'
  AND t.kind_id = 1
  AND mc.company_type_id = 1;
