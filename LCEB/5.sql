SELECT cn.id, cn.name, cn.imdb_index, t.id AS movie_id, t.title, ci.nr_order, k.keyword
FROM char_name cn
JOIN cast_info ci ON ci.person_role_id = cn.id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE (cn.name LIKE '_av%K%' OR cn.name LIKE 'Kira_ %hill')
  AND cn.name_pcode_nf = 'N35'
  AND cn.md5sum IS NOT NULL
  AND t.title LIKE 'S% _n_el B_rri_'
  AND k.keyword NOT LIKE '%-_i_k'
  AND ci.nr_order <= 2
  AND t.production_year BETWEEN 1986 AND 2011;
