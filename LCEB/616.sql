SELECT t.id, t.title
FROM title t
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id
      AND k.keyword LIKE 'campus'
)
  AND co.name LIKE '_u_bri%i% _nd%d_n_s'
  AND mc.company_type_id = 2
  AND t.production_year >= 2011;
