SELECT t.id, t.title
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE kt.kind = 'video game'
  AND t.production_year > 1994
  AND n.gender = 'm'
  AND k.keyword LIKE '%wh_l_-%w_'
  AND c.name LIKE 'SuRee_ Fi_m_'
  AND EXISTS (
        SELECT 1
        FROM person_info pi
        JOIN info_type it ON pi.info_type_id = it.id
        WHERE pi.person_id = n.id
          AND it.info = 'bottom 10 rank'
          AND pi.info IS NOT NULL
  )
  AND NOT EXISTS (
        SELECT 1
        FROM movie_link ml
        WHERE ml.movie_id = t.id
  )
  AND c.country_code = '[ru]'
  AND ci.nr_order <> 1;
