SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (t.title LIKE '(_1.120_4_' OR n.name LIKE 'S_o_t_ Dav%')
  AND ci.nr_order <= 34
  AND t.production_year <= 1964
  AND t.kind_id = 7
  AND k.keyword NOT LIKE 't_r_w_n%wa%on%-%s_ss_o_s'
ORDER BY t.production_year DESC
LIMIT 200;
