SELECT akat.movie_id, akat.title, MAX(akat.production_year) AS latest_year, COUNT(DISTINCT ci.person_id) AS main_cast
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN name n ON ci.person_id = n.id
JOIN role_type rt ON ci.role_id = rt.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE ci.nr_order <= 17
  AND akat.production_year BETWEEN 1933 AND 1986
  AND rt.role IN ('costume designer', 'producer', 'editor', 'actress', 'director')
  AND n.name LIKE 'Hira_a_ Ke_shi'
  AND akat.title LIKE '_olot%: The Ma%Behind the Co%ta_l'
  AND k.keyword LIKE 'metal-gear'
  AND akat.season_nr BETWEEN 2 AND 11
  AND akat.episode_nr IS NOT NULL
GROUP BY akat.movie_id, akat.title
ORDER BY main_cast DESC;
