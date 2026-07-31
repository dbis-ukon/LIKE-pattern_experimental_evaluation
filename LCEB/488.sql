SELECT akat.id, akat.title, akat.production_year, akat.kind_id, akat.md5sum,
       mc.company_id, c.name AS company_name, k.keyword
FROM aka_title akat
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE 'Kill% _i%'
  AND c.country_code = '[ru]'
  AND k.keyword LIKE 'argu%l-fo_est';
