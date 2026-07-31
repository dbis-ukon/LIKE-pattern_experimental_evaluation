SELECT t.id, t.title, co.name
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE '_-a_'
)
  AND co.name LIKE 'Won _e%a Enter_a%ment'
  AND mc.company_type_id = 1
  AND t.production_year >= 2007;
