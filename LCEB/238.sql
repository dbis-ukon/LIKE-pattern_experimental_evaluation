SELECT akat.movie_id,
       t.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MIN(akat.episode_nr) AS first_episode,
       MAX(akat.episode_nr) AS last_episode
FROM aka_title akat
JOIN title t ON akat.movie_id = t.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE 'Crazy for You'
  AND t.title LIKE 'Pr_sque rien avec Luc Ferrari'
  AND k.keyword LIKE 's%g%t%ab_s%'
  AND k.keyword NOT LIKE 're_ere_ce_to-%a%d'
  AND akat.episode_nr IS NOT NULL
  AND akat.production_year BETWEEN 1900 AND 1978
GROUP BY akat.movie_id, t.title
ORDER BY num_keywords DESC;
