SELECT t.id, n.name, cn.name, co.name
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE '%me-zo_e'
)
  AND n.name LIKE 'Ra_hje Ellis'
  AND cn.name LIKE 'H%el%- Curat_r_ %st_e%rd _r%'
  AND co.name LIKE 'Sno_padelic_Films Inc.'
  AND ci.nr_order <= 6
  AND t.production_year BETWEEN 1921 AND 1996;
