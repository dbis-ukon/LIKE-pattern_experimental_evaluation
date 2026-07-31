SELECT t.title, t.production_year
FROM title t
WHERE t.title LIKE '_is%Pis_!'
  AND t.production_year >= 1912
  AND t.episode_of_id IS NULL
  AND t.season_nr IS NULL
  AND t.episode_nr IS NULL
  AND t.kind_id IN (2, 1, 7)
ORDER BY t.production_year DESC;
