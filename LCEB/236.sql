SELECT cn.name AS character_name,
       ci.role_id,
       COUNT(DISTINCT akat.movie_id) AS movie_count,
       MAX(akat.production_year) AS latest_year
FROM aka_title akat
JOIN cast_info ci ON akat.movie_id = ci.movie_id
JOIN char_name cn ON ci.person_id = cn.id
JOIN name n ON cn.id = n.id
JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
JOIN keyword k ON mk.keyword_id = k.id
JOIN movie_companies mc ON akat.movie_id = mc.movie_id
JOIN company_name c ON mc.company_id = c.id
JOIN title t ON akat.movie_id = t.id
WHERE cn.name LIKE '%o% %ebo%'
  AND n.name LIKE 'Merrill'
  AND akat.title LIKE 'Family'
  AND t.title LIKE 'He_o'
  AND k.keyword LIKE '%a%n%be_'
  AND c.name LIKE '_a%lms'
  AND akat.production_year BETWEEN 1986 AND 1991
GROUP BY cn.name, ci.role_id
ORDER BY movie_count DESC;
