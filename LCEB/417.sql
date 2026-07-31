SELECT akat.movie_id, akat.title, COUNT(DISTINCT k.keyword) AS keyword_count, MAX(akat.episode_nr) AS last_episode
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE 'Zwei_ein_a% Herzen'
  AND k.keyword LIKE '%ll%-_nt_-%'
  AND c.country_code = '[us]'
  AND akat.episode_nr IS NOT NULL
  AND mc.company_type_id IN (2, 1)
  AND akat.production_year BETWEEN 2001 AND 2004
GROUP BY akat.movie_id, akat.title
ORDER BY keyword_count DESC;
