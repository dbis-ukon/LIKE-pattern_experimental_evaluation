SELECT t.id, n.name_pcode_nf
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE 'cut-in-half-by-an-e_evator'
  AND t.title LIKE 'Mai_ol'
  AND n.name LIKE '%hy%E%et_'
  AND n.name_pcode_nf IS NOT NULL
  AND t.production_year > 1995;
