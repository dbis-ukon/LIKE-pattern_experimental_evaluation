SELECT t.title
FROM title t
WHERE t.title LIKE '_a_io%t_e _ô p%'
  AND t.production_year BETWEEN 1988 AND 2009
  AND t.season_nr = 6
  AND t.episode_nr <= 3
  AND t.episode_of_id IS NOT NULL
ORDER BY t.production_year DESC;
