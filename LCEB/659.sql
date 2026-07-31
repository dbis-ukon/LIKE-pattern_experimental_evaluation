SELECT t.title, n.name, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.kind_id = 1
  AND k.keyword LIKE '%nv_y-_a_far_'
  AND ci.nr_order <= 21
  AND (t.title LIKE 'The T_mbs_of%e A%e_t Japan%e _mp_rors' OR n.name LIKE 'P_um_')
  AND k.phonetic_code IS NOT NULL
  AND t.kind_id IN (1, 3, 7)
ORDER BY t.production_year DESC
LIMIT 200;
