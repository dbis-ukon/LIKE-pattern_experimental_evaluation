SELECT sub.name AS character_name,
       AVG(keyword_count) AS avg_keywords
FROM (
    SELECT cn.id AS character_id,
           cn.name,
           COUNT(DISTINCT k.keyword) AS keyword_count
    FROM aka_title akat
    JOIN cast_info ci ON akat.movie_id = ci.movie_id
    JOIN char_name cn ON ci.person_id = cn.id
    JOIN name n ON cn.id = n.id
    JOIN movie_keyword mk ON akat.movie_id = mk.movie_id
    JOIN keyword k ON mk.keyword_id = k.id
    JOIN title t ON akat.movie_id = t.id
    WHERE cn.name LIKE 'Ro%Bieseman_'
      AND t.title LIKE '%29_3)'
    GROUP BY cn.id, cn.name
) AS sub
GROUP BY sub.name
ORDER BY avg_keywords DESC;
