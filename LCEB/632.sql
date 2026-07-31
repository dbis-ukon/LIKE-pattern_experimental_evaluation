SELECT t.id, cn.name, t.season_nr
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN char_name cn ON ci.person_role_id = cn.id
WHERE EXISTS (
    SELECT 1
    FROM movie_keyword mk
    JOIN keyword k ON mk.keyword_id = k.id
    WHERE mk.movie_id = t.id AND k.keyword LIKE '%ec%d%u_t_r'
)
  AND cn.name LIKE 'P%ce Superinte_d_nt''_ wife'
  AND ci.nr_order <= 17
  AND t.production_year >= 2006;
