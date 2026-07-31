SELECT
    t.id,
    t.title,
    t.production_year,
    kt.kind,
    n.name AS actor_name,
    n.gender,
    cn.name AS character_name,
    k.keyword
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN name n ON ci.person_id = n.id
JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN company_type ct ON mc.company_type_id = ct.id
WHERE t.production_year BETWEEN 2006 AND 2011
  AND t.production_year IS NOT NULL
  AND t.series_years IS NOT NULL
  AND t.episode_of_id IS NULL
  AND kt.kind = 'tv movie'
  AND rt.role = 'costume designer'
  AND n.gender = 'm'
  AND ci.nr_order < 2
  AND ci.note IS NULL
  AND cn.name LIKE '%a_l%'
  AND (n.name LIKE 'De%a_Cru_' or k.keyword LIKE 'r%-e_i_')
  AND k.phonetic_code IS NOT NULL
  AND c.country_code = '[ca]'
  AND ct.kind = 'production companies'
  AND t.title LIKE '(19%-_3%6_'
ORDER BY t.production_year DESC, t.id;
