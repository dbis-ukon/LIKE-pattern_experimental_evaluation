SELECT n.name, cn.name, a.title, k.keyword
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN aka_title a ON ci.movie_id = a.movie_id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE 'K%l_n_ %le'
  AND cn.name LIKE '%Hi%'
  AND a.title LIKE '%ch_b%- _i% % z%S%'
  AND k.keyword LIKE '%eroi_e'
  AND a.production_year >= 1964
  AND ci.nr_order <= 4
  AND cn.name_pcode_nf IS NOT NULL;
