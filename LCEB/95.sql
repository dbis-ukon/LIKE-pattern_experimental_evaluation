SELECT DISTINCT n.name, a.title, k.keyword
FROM name n
JOIN cast_info ci ON n.id = ci.person_id
JOIN aka_title a ON ci.movie_id = a.movie_id
JOIN movie_keyword mk ON a.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
WHERE n.name LIKE 'Goranova'
  AND a.title LIKE '_e_n Vater_v% %stern'
  AND k.keyword LIKE 'cri%-bos_'
  AND a.production_year >= 1945
  AND a.season_nr IS NOT NULL
  AND ci.nr_order <= 6;
