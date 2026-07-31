SELECT t.title, k.keyword, rt.role
FROM title t
JOIN cast_info ci     ON t.id = ci.movie_id
JOIN role_type rt     ON ci.role_id = rt.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k        ON mk.keyword_id = k.id
WHERE t.title LIKE 'T_e Br%k_o_n'
  AND k.keyword LIKE '%i%al'
  AND rt.role LIKE '%actor%'
  AND t.production_year > 2008;
