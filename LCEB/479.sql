SELECT c.id, c.name, c.country_code, c.md5sum,
       mc.movie_id, k.keyword
FROM company_name c
JOIN movie_companies mc ON c.id = mc.company_id
JOIN movie_keyword mk ON mc.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE c.name LIKE '%ris _i%Pr%i_ns'
  AND k.keyword LIKE 'o%e_-si%er-you_g%-_r_the_'
  AND mc.company_type_id = 1;
