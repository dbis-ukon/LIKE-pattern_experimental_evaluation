SELECT n.name, t.title, t.production_year, pi.info
FROM title t
JOIN cast_info ci ON t.id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN person_info pi ON n.id = pi.person_id
WHERE (n.name LIKE 'Fe%ari' OR n.name LIKE 'B_we%')
  AND t.production_year BETWEEN 1997 AND 2008
  AND t.episode_nr <= 62
  AND t.kind_id IN (1, 6, 2, 3, 7)
  AND t.season_nr IS NOT NULL
  AND t.title LIKE 'H_t%one _ %So%w_s_'
ORDER BY t.production_year DESC
LIMIT 100;
