SELECT t.id, akat.title, co.name
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE '_ee-%'
)
  AND akat.title LIKE '_i%t%ip_i'
  AND co.name LIKE '%on%ô% %'
  AND mc.company_type_id = 2
  AND t.production_year >= 2013;
