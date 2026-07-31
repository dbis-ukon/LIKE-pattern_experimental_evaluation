SELECT c.id, c.name, c.country_code, c.md5sum,
       mc.movie_id, akat.title, k.keyword
FROM company_name c
JOIN movie_companies mc ON c.id = mc.company_id
JOIN aka_title akat ON mc.movie_id = akat.movie_id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE c.name LIKE '%''%de_'
  AND akat.production_year BETWEEN 1984 AND 2013
  AND k.keyword LIKE 'f_mal_-ba%-lead_r';
