SELECT k.keyword, COUNT(DISTINCT t.id) AS movie_count
FROM keyword k
JOIN movie_keyword mk ON mk.keyword_id = k.id
JOIN title t ON t.id = mk.movie_id
WHERE k.keyword LIKE '_a_c%s%w'
  AND t.production_year >= 2000
  AND t.season_nr IS NOT NULL
  AND t.episode_nr <= 23
GROUP BY k.keyword
ORDER BY movie_count DESC;
