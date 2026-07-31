SELECT t.id, t.title
FROM title t
JOIN kind_type kt ON t.kind_id = kt.id
JOIN cast_info ci ON t.id = ci.movie_id
JOIN role_type rt ON ci.role_id = rt.id
JOIN name n ON ci.person_id = n.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE t.production_year BETWEEN 1963 AND 1973
  AND kt.kind <> 'episode'
  AND rt.role IN ('composer', 'production designer', 'miscellaneous crew', 'director', 'costume designer')
  AND ci.note IS NULL
  AND n.name LIKE '_te%ns_n'
  AND c.country_code IN ('[br]', '[gb]', '[gr]', '[fr]', '[be]')
  AND c.name NOT LIKE 'Izm Films'
  AND t.episode_of_id IS NULL;
