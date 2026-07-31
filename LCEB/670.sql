SELECT n.name, t.title, k.keyword, t.production_year
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE k.keyword LIKE '_r_gr%o_s_up'
  AND t.title LIKE '%Fa_a%L_t%r'
  AND ci.nr_order <= 10
  AND (n.name LIKE 'Mar% _rz%zt_f ''K%' OR n.name LIKE '_olas')
  AND t.kind_id IN (1, 2, 3, 7)
  AND n.gender = 'm'
ORDER BY n.name;
