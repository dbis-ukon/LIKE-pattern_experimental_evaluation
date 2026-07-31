SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
WHERE akat.title LIKE '_n _he Dark'
  AND k.keyword LIKE '%t%de%il_n_'
  AND c.name LIKE 'Ante%s'
  AND akat.production_year BETWEEN 1923 AND 1989
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
