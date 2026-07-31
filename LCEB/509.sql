SELECT
    t.title,
    mi.info,
    it.info AS info_type
FROM title t
JOIN movie_info mi ON t.id = mi.movie_id
JOIN info_type it ON mi.info_type_id = it.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE t.title LIKE '%0_3-_6-%)'
  AND mi.info LIKE '%budget%'
  AND it.info LIKE '%gross%'
  AND k.keyword LIKE 'refer_nce-to-saint-clo_ilde'
  AND t.production_year > 2006
  AND t.kind_id = 2;
