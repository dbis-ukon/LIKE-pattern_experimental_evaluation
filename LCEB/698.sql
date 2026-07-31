SELECT lt.link AS link_type,
       COUNT(*) AS n_links,
       COUNT(DISTINCT ml.movie_id) AS n_source_movies
FROM movie_link ml
JOIN link_type lt ON ml.link_type_id = lt.id
JOIN title t ON ml.movie_id = t.id
JOIN movie_keyword mk ON t.id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON t.id = mc.movie_id
JOIN company_name cn ON mc.company_id = cn.id
WHERE t.title LIKE '(_0%'
  AND k.keyword LIKE '_a_li%-%o%it%n_''s%alys_'
  AND cn.name LIKE 'Ep_ch %l%i_g'
  AND cn.country_code = '[us]'
  AND mc.company_type_id IN (1, 2)
  AND mc.note IS NULL
  AND t.kind_id IN (2, 1, 3, 7)
  AND t.episode_of_id IS NULL
  AND lt.link NOT LIKE '%alternate%'
  AND k.phonetic_code IS NOT NULL
GROUP BY lt.link
ORDER BY n_links DESC;
