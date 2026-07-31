SELECT n.name, COUNT(DISTINCT k.id) AS keyword_count
FROM name n
JOIN char_name cn ON cn.id = n.id
JOIN cast_info ci ON ci.person_id = cn.id
JOIN aka_title a ON a.movie_id = ci.movie_id
JOIN movie_keyword mk ON mk.movie_id = a.movie_id
JOIN keyword k ON k.id = mk.keyword_id
WHERE n.name LIKE 'Smith'
  AND k.keyword LIKE 'person-thought-dead-i_-al_ve'
  AND a.production_year BETWEEN 1933 AND 1982
  AND a.season_nr = 2
GROUP BY n.name
ORDER BY keyword_count DESC;
