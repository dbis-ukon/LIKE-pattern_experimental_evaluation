SELECT akat.movie_id, akat.title, COUNT(DISTINCT ci.person_id) AS cast_count, MIN(akat.episode_nr) AS first_episode, MAX(akat.episode_nr) AS last_episode
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE akat.title LIKE '%ge%a'
  AND cn.name LIKE '_a%i_e%r%'
  AND k.keyword LIKE '%fe%ce%-im%mar%'
  AND c.name LIKE 'P_rago%rk_ti%'
  AND ci.nr_order <= 6
  AND akat.production_year BETWEEN 1962 AND 2009
  AND akat.episode_nr BETWEEN 3 AND 23
GROUP BY akat.movie_id, akat.title
ORDER BY cast_count DESC;
