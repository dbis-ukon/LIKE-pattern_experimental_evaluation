SELECT cn.name AS character_name,
       ci.role_id,
       MIN(akat.season_nr) AS first_season,
       MAX(akat.season_nr) AS last_season,
       COUNT(DISTINCT akat.movie_id) AS movie_count
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE 'Igor Brauwieser'
  AND n.name LIKE 'Hill%De_etrius'
  AND ci.nr_order <= 24
  AND akat.title LIKE 'O_Ma%ês'
  AND t.title LIKE '_#%41_'
  AND k.keyword LIKE 'cider'
  AND akat.season_nr IS NOT NULL
GROUP BY cn.name, ci.role_id
ORDER BY movie_count DESC;
