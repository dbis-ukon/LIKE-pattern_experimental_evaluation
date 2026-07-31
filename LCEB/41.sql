SELECT akat.movie_id, akat.title,
       COUNT(DISTINCT k.keyword) AS num_keywords,
       MAX(akat.episode_nr) AS max_episode,
       COUNT(DISTINCT ci.person_id) AS main_cast,
       MIN(akat.production_year) AS first_year,
       MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
WHERE (akat.title LIKE '%p%T%an%' OR akat.title LIKE 'E%Jw%muk_i')
  AND k.keyword LIKE 'o_e_-source-t_chno%gy'
  AND (c.country_code = '[gb]' OR c.name LIKE 'G%nus%e%n%nt')
  AND n.gender = 'f'
  AND akat.episode_nr BETWEEN 2 AND 3
  AND akat.production_year BETWEEN 1970 AND 1986
GROUP BY akat.movie_id, akat.title
ORDER BY num_keywords DESC;
