SELECT
    t.title,
    k.keyword,
    COUNT(DISTINCT t.id) AS movie_count,
    MAX(t.episode_nr) AS max_episode
FROM title t
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE k.keyword LIKE 'mormon'
  AND t.episode_nr > 5
  AND t.production_year >= 2011
GROUP BY t.title, k.keyword
ORDER BY movie_count DESC;
