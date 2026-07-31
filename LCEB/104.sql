SELECT cn.name, k.keyword, COUNT(DISTINCT t.id) AS keyword_movies
FROM char_name cn
JOIN cast_info ci ON ci.person_id = cn.id
JOIN title t ON t.id = ci.movie_id
JOIN movie_keyword mk ON mk.movie_id = t.id
JOIN keyword k ON k.id = mk.keyword_id
WHERE cn.name LIKE 'U_s%i'
  AND k.keyword LIKE 'reference-to-doris-day'
  AND t.production_year BETWEEN 1996 AND 2002
  AND (ci.nr_order <= 8 OR t.season_nr = 1)
  AND t.episode_nr IS NOT NULL
GROUP BY cn.name, k.keyword
ORDER BY keyword_movies DESC;
