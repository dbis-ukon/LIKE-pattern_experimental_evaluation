SELECT t.id, t.series_years
FROM title t
JOIN aka_title akat ON t.id = akat.movie_id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name co ON mc.company_id = co.id
WHERE (k.keyword LIKE '_i%n' OR k.keyword LIKE '%f%o_')
  AND t.title LIKE 'Le %e%'
  AND n.name LIKE 'Br%r_'
  AND akat.title LIKE 'Beverly Hills _ar Park'
  AND co.name LIKE 'Rock Rose Entertai_me_t'
  AND cn.name LIKE 'Pela_ia Karra'
  AND t.series_years IS NOT NULL
  AND t.season_nr >= 28
  AND ci.nr_order <= 4
  AND n.gender = 'f';
