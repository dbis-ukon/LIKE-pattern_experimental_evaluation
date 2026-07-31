SELECT c.id, c.name, c.country_code, c.md5sum,
       mc.movie_id, akat.title, k.keyword
FROM company_name c
JOIN movie_companies mc ON c.id = mc.company_id
JOIN aka_title akat ON mc.movie_id = akat.movie_id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE c.name LIKE '%ve_s_t% %l_n%s Ar_h% U%na%a_p_i%'
  AND akat.production_year BETWEEN 1938 AND 1960
  AND k.keyword LIKE '_c%bridg_';
