SELECT k.keyword, COUNT(DISTINCT t.id) AS total_movies
FROM keyword k
JOIN movie_keyword mk ON mk.keyword_id = k.id
JOIN title t ON t.id = mk.movie_id
WHERE k.keyword LIKE '%v%ne%'
  AND t.season_nr = 5
  AND t.episode_nr <= 12
  AND t.production_year >= 1951
GROUP BY k.keyword
ORDER BY total_movies DESC;
