SELECT t.id, ci.person_id
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE k.keyword LIKE 'corsair'
  AND t.title LIKE 'P_o_'
  AND n.name LIKE 'Do_glas_ R_bert'
  AND ci.person_id > 2570979
  AND t.production_year BETWEEN 2005 AND 2009
  AND n.gender = 'f';
