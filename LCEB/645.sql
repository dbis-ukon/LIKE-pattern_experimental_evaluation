SELECT
    t.id,
    t.title,
    t.production_year,
    kt.kind,
    n.name AS actor_name,
    cn.name AS character_name,
    k.keyword,
    c.name AS company_name
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN name n ON ci.person_id = n.id
LEFT JOIN char_name cn ON ci.person_role_id = cn.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
LEFT JOIN movie_companies mc ON t.id = mc.movie_id
LEFT JOIN company_name c ON mc.company_id = c.id
LEFT JOIN company_type ct ON mc.company_type_id = ct.id
WHERE t.production_year BETWEEN 1993 AND 2012
  AND t.series_years IS NOT NULL
  AND t.episode_of_id IS NULL
  AND kt.kind = 'movie'
  AND rt.role = 'guest'
  AND n.gender = 'm'
  AND ci.nr_order < 25
  AND t.title LIKE 'L%x'
  AND (cn.name LIKE 'Backf%c_ #2' OR cn.name IS NULL)
  AND (k.keyword LIKE 'fa%i%st_de_t' OR k.keyword LIKE 'globally-syndicated-celebrity-tv-_how')
  AND (ct.kind = 'distributors' OR ct.kind IS NULL)
  AND EXISTS (
        SELECT 1
        FROM movie_info mi
        JOIN info_type it ON mi.info_type_id = it.id
        WHERE mi.movie_id = t.id
          AND it.info = 'birth notes'
          AND mi.info IS NOT NULL
  )
ORDER BY t.production_year DESC, t.id
LIMIT 100;
