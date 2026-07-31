SELECT
    rt.role,
    k.keyword,
    COUNT(DISTINCT t.id) AS movies_count
FROM role_type rt
JOIN cast_info ci ON rt.id = ci.role_id
JOIN title t ON ci.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE rt.role LIKE '%actor%'
  AND k.keyword LIKE '%y%es_'
  AND t.season_nr >= 5
  AND t.episode_nr > 22
GROUP BY rt.role, k.keyword
ORDER BY movies_count DESC;
