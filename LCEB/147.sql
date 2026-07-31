SELECT t.title, COUNT(*) AS episodes
FROM title t
WHERE t.title LIKE 'B-%b%'
  AND t.season_nr = 1
  AND t.production_year BETWEEN 1969 AND 2005
  AND t.episode_nr <= 50
  AND t.episode_of_id IS NOT NULL
GROUP BY t.title
ORDER BY episodes DESC;
